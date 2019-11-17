using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using AutoDialer.Console;
using AutoDialer.Console.Models;
using FluentNHibernate.Cfg;
using FluentNHibernate.Cfg.Db;
using NLog;

namespace AutoDialer
{
    class Program
    {
        /// <summary>
        /// Логирование
        /// </summary>
        static readonly Logger _logger = LogManager.GetCurrentClassLogger();

        static async Task Main()
        {
            var setting = await Setting.Reload();

            try
            {
                if (setting is null)
                {
                    throw new ArgumentNullException(nameof(setting));
                }

                Log("MAIN: Setting: Reload");

                Log($"MAIN: Setting: HourBgn: {setting.HourBgn}" );
                Log($"MAIN: Setting: HourEnd: {setting.HourEnd}" );
                Log($"MAIN: CurrentTime Hour: {DateTime.Now.Hour}");
                Log($"MAIN: OutgoingDir: {setting.OutgoingDir}");
                Log($"MAIN: DialType: {setting.DialType}");

                var trunks = await Trunk.GetListAsync();

                var totalOutgoings = await Outgoing.GetInsertedListAsync();

                Log($"MAIN: Outgoings: Count: {totalOutgoings.Count}");

                var outgoingQueue = new Queue<Outgoing>(totalOutgoings);

                DateTime bgnRun = DateTime.Now;

                DateTime endRun = DateTime.Now;

                while (true)
                {
                    try
                    {
                        endRun = DateTime.Now;

      //                  File.WriteAllTextAsync("/tmp/avtodialer.run", $"{(endRun - bgnRun).TotalMilliseconds}");

                        if ((endRun - bgnRun).TotalMilliseconds < 1000)
                        {
                            await Task.Delay(1000);
                        }

                        bgnRun = DateTime.Now;

                        Log("RUN: BGN");

                        if (setting.DialType != SettingDialType.DialAsyncCSharp)
                        {
                            Log("RUN: BGN: CONTINUE: Пропускаем итерацию: Указана иная служба генерации вызовов на обзвон в настройках");

                            continue;
                        }

                        if (!(setting.HourBgn <= DateTime.Now.Hour && DateTime.Now.Hour < setting.HourEnd))
                        {
                            Log("RUN: BGN: CONTINUE: Пропускаем итерацию: Находимся за рамками рабочего времени");

                            continue;
                        }

                        var activedTrunks = trunks.Where(x => x.Actived == true);

                        var callCountTotal = activedTrunks.Sum(x => x.CallCount);

                        Log($"RUN: BGN: TotalCallCount: {callCountTotal}");

                        foreach (var trunk in activedTrunks)
                        {
                            Log($"RUN: BGN: TRUNK: {trunk.Title}");

                            //int fileCount = Directory.GetFiles(setting.OutgoingDir, $"*{trunk.Title}*", SearchOption.TopDirectoryOnly).Length;

                            //int fileCount = ReturnFiles(new DirectoryInfo(setting.OutgoingDir), $"*{trunk.Title}*").Length;

                            Log($"RUN: BGN: TRUNK: {trunk.Title}: FileCount: {fileCount} / {trunk.CallMax}");

                            if (fileCount > trunk.CallMax)
                            {
                                Log($"RUN: BGN: TRUNK: {trunk.Title} CONTINUE: Пропускаем рабочий канал: Количество одновременно обрабатываемых вызовов превышает установленное значение");

                                continue;
                            }

                            for (int i = 0; i < trunk.CallCount; i++)
                            {
                                if (outgoingQueue.Count == 0)
                                {
                                    Log($"RUN: BGN: TRUNK: {trunk.Title} CONTINUE: Пропускаем рабочий канал: Очередь исходящих пуста");

                                    continue;
                                }

                                var outgoing = outgoingQueue.Dequeue();

                                Log($"RUN: BGN: TRUNK: Dialing: {outgoing.Telephone}");

                                //await trunk.Dialing(outgoing, setting);

                                Task.Run(async () => await trunk.Dialing(outgoing, setting));

                            }
                        }


                        Log("RUN: END");
                    }
                    catch (Exception exc)
                    {
                        System.Console.WriteLine(exc.ToString());
                        Log(exc.ToString());
                    }
                }  // whele

            }
            catch(Exception exc)
            {
                System.Console.Write(exc.ToString());
                Log(exc.ToString());
            }
            finally
            {
                // Ensure to flush and stop internal timers/threads before application-exit (Avoid segmentation fault on Linux)
                LogManager.Shutdown();
            }

        }

        private static FileInfo[] ReturnFiles(DirectoryInfo dir, string fileSearchPattern)
        {
            return dir.GetFiles(fileSearchPattern, SearchOption.TopDirectoryOnly);
        }

        static void Log(string msg)
        {
            _logger.Debug(msg);

            System.Console.WriteLine(msg);
        }
        
    }
}
