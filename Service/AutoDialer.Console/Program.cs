using AutoDialer.Console;
using AutoDialer.Console.Models;
using AutoDialer.Console.Performance;
using AutoDialer.Console.Repositories;
using NLog;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

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
		/// Логирование
		/// </summary>
		static readonly Logger _logger = LogManager.GetCurrentClassLogger();

		delegate void MethodContainer(Trunk trunk, Outgoing outgoing, Setting setting, Config config, OutgoingRepository outgoingRepository);

		static event MethodContainer OnDialing;
						
		static async Task Main()
        {
			OnDialing += Program_onDialing;

			try
			{
				var dataAccessLayer = new DataAccessLayer();

				var session = dataAccessLayer.Open();

				var settingRepository = new SettingRepository(session);

				var trunkRepository = new TrunkRepository(session);

				var outgoingRepository = new OutgoingRepository(session);

				var configRepository = new ConfigRepository(session);

				var setting = await Setting.Reload(settingRepository);

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

				var config = await Config.Reload(configRepository);

				if (config is null)
				{
					throw new ArgumentNullException(nameof(config));
				}

				Log("MAIN: Config: Reload");

				Log($"MAIN: Config: ContryPrefix: {config.ContryPrefix}");
				Log($"MAIN: Config: DefaultTrunkContext: {config.DefaultTrunkContext}");
				Log($"MAIN: Config: IsOutgoingDeleted: {config.IsOutgoingDeleted}");

				var trunks = await Trunk.GetListAsync(trunkRepository);

				var totalOutgoings = await Outgoing.GetInsertedListAsync(outgoingRepository);

				Log($"MAIN: Outgoings: Count: {totalOutgoings.Count}");

				var outgoingQueue = new Queue<Outgoing>(totalOutgoings);

				DateTime bgnRun = DateTime.Now;

				DateTime endRun = DateTime.Now;

				var outgoingFiles = Directory.GetFiles(setting.OutgoingDir, $"*", SearchOption.TopDirectoryOnly);

				ulong index = 0;

				var delayCounter = new Counter("delay", "Ожидание между опросами", _logger);

				var activedTrunksCounter = new Counter("activedTrunks", "Получение активных транков", _logger);

				var transactionCounter = new Counter("beginTransaction", "Время жизни транзакции", _logger);

				var trunkCallCountCounter = new Counter("trunkCallCount", "Время обработки транка", _logger);

				var commitTransactionCounter = new Counter("commitTransaction", "Время подтверждения транзакции", _logger);

				while (true)
				{
					try
					{
						index++;

						endRun = DateTime.Now;

						delayCounter.Start();

						await File.WriteAllTextAsync("/tmp/avtodialer.run", $"{(endRun - bgnRun).TotalMilliseconds}");

						if ((endRun - bgnRun).TotalMilliseconds < 1000)
						{
							await Task.Delay(1000 - ((int)(endRun - bgnRun).TotalMilliseconds));
						}

						bgnRun = DateTime.Now;

						Log("RUN: BGN");

						delayCounter.Stop();

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

						activedTrunksCounter.Start();

						var activedTrunks = trunks.Where(x => x.Actived == true);

						var callCountTotal = activedTrunks.Sum(x => x.CallCount);

						activedTrunksCounter.Stop();

						Log($"RUN: BGN: TotalCallCount: {callCountTotal}");

						transactionCounter.Start();

						session.BeginTransaction();

						foreach (var trunk in activedTrunks)
						{
							trunkCallCountCounter.Start();

							Log($"RUN: BGN: TRUNK: {trunk.Title}");

							int fileCount = 0;

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

								OnDialing?.Invoke(trunk, outgoing, setting, config, outgoingRepository);
							}

							trunkCallCountCounter.Stop();
						}

						commitTransactionCounter.Start();

						await session.FlushAsync();

						await session.Transaction.CommitAsync();

						commitTransactionCounter.Stop();

						transactionCounter.Stop();

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

		}

		private static void ManagerConnection_UnhandledEvent(object sender, AsterNET.NetStandard.Manager.Event.ManagerEvent e)
		{
			throw new NotImplementedException();
		}

		private static async void Program_onDialing(Trunk trunk, Outgoing outgoing, Setting setting, Config config, OutgoingRepository outgoingRepository)
		{
			try
			{
				Log($"EVENT: Program_onDialing: {trunk.Title} {outgoing.Telephone}");
								
				await trunk.DialingAsync(outgoing, setting, config, outgoingRepository);

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
