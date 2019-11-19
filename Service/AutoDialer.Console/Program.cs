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
        static object _lock = new object();

		/// <summary>
		/// Синхронизирует логирование
		/// </summary>
		static readonly object _loggerSync = new object();

		/// <summary>
		/// Синхронизирует выполнение запросов
		/// </summary>
		static readonly object _httpClientSync = new object();

		/// <summary>
		/// https://csharp.hotexamples.com/examples/AsterNET.Manager/ManagerConnection/-/php-managerconnection-class-examples.html
		/// </summary>
		static AsterNET.NetStandard.Manager.ManagerConnection ManagerConnection = new AsterNET.NetStandard.Manager.ManagerConnection("ast11", 5038, "avtodialer", "NoO5ijyFWDF6lgquTM7n");

		/// <summary>
		/// Клиент запросов
		/// </summary>
		private static readonly HttpClient _httpClient = new HttpClient();

		/// <summary>
		/// Логирование
		/// </summary>
		static readonly Logger _logger = LogManager.GetCurrentClassLogger();

		delegate void MethodContainer(Trunk trunk, Outgoing outgoing, Setting setting);

		static event MethodContainer onDialing;


        static void Main()
        {
			onDialing += Program_onDialing;


			Task.Run(async () =>
			{
				var setting = await Setting.Reload();

				try
				{
					if (setting is null)
					{
						throw new ArgumentNullException(nameof(setting));
					}

					Log("MAIN: Setting: Reload");

					Log($"MAIN: Setting: HourBgn: {setting.HourBgn}");
					Log($"MAIN: Setting: HourEnd: {setting.HourEnd}");
					Log($"MAIN: CurrentTime Hour: {DateTime.Now.Hour}");
					Log($"MAIN: OutgoingDir: {setting.OutgoingDir}");
					Log($"MAIN: DialType: {setting.DialType}");

					var trunks = await Trunk.GetListAsync();

					var totalOutgoings = await Outgoing.GetInsertedListAsync();

					Log($"MAIN: Outgoings: Count: {totalOutgoings.Count}");

					var outgoingQueue = new Queue<Outgoing>(totalOutgoings);

					DateTime bgnRun = DateTime.Now;

					DateTime endRun = DateTime.Now;

					var outgoingFiles = Directory.GetFiles(setting.OutgoingDir, $"*", SearchOption.TopDirectoryOnly);

					ulong index = 0;

					while (true)
					{
						try
						{
							index++;

							endRun = DateTime.Now;

							File.WriteAllTextAsync("/tmp/avtodialer.run", $"{(endRun - bgnRun).TotalMilliseconds}");

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

							if (index % 10 == 0)
							{
								Task.Run(() =>
								{
									lock (_lock)
									{
										outgoingFiles = Directory.GetFiles(setting.OutgoingDir, $"*", SearchOption.TopDirectoryOnly);

										Log($"RUN: BGN: outgoingFiles: Обновлен список файл вызовов: {outgoingFiles.Length}");
									}
								});
							}

							var activedTrunks = trunks.Where(x => x.Actived == true);

							var callCountTotal = activedTrunks.Sum(x => x.CallCount);

							Log($"RUN: BGN: TotalCallCount: {callCountTotal}");

							foreach (var trunk in activedTrunks)
							{
								Log($"RUN: BGN: TRUNK: {trunk.Title}");

								int fileCount = 0;

								lock (_lock)
								{
									fileCount = outgoingFiles.Where(x => x.Contains(trunk.Title)).Count();
								}

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

									Log($"RUN: BGN: TRUNK: Event: {outgoing.Telephone}");

									onDialing?.Invoke(trunk, outgoing, setting);

									//trunk.Dialing(outgoing, setting, _logger);

									//Task.Run(async () => await trunk.Dialing(outgoing, setting));

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
				catch (Exception exc)
				{
					System.Console.Write(exc.ToString());
					Log(exc.ToString());
				}
				finally
				{
					// Ensure to flush and stop internal timers/threads before application-exit (Avoid segmentation fault on Linux)
					LogManager.Shutdown();
				}
			}).GetAwaiter().GetResult();

        }

		private static void ManagerConnection_UnhandledEvent(object sender, AsterNET.NetStandard.Manager.Event.ManagerEvent e)
		{
			throw new NotImplementedException();
		}

		private static async void Program_onDialing(Trunk trunk, Outgoing outgoing, Setting setting)
		{
			try
			{
				Log($"EVENT: Program_onDialing: {trunk.Title} {outgoing.Telephone}");
								
				await trunk.Dialing(outgoing, setting, ManagerConnection);



			}
			catch (Exception exc)
			{
				Log(exc.ToString());
			}
			
		}

		private static FileInfo[] ReturnFiles(DirectoryInfo dir, string fileSearchPattern)
        {
            return dir.GetFiles(fileSearchPattern, SearchOption.TopDirectoryOnly);
        }

		/// <summary>
		/// Логирование
		/// </summary>
		/// <param name="msg"></param>
        static void Log(string msg)
        {
			lock (_loggerSync)
			{
				_logger.Debug(msg);

				System.Console.WriteLine(msg);
			}
		}
        
    }
}
