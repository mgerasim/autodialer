﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using AsterNET.NetStandard.Manager;
using AsterNET.NetStandard.Manager.Action;
using AsterNET.NetStandard.Manager.Response;
using AutoDialer.Console.Models.Base;
using AutoDialer.Console.Repositories;
using NLog;

namespace AutoDialer.Console.Models
{
	/// <summary>
	/// Рабочий канал
	/// </summary>
	public class Trunk : Record
	{
		/// <summary>
		/// Наименование
		/// </summary>
		public virtual string Title { get; set; }

		/// <summary>
		/// Рабочий канал активирован для работы
		/// </summary>
		public virtual bool Actived { get; set; }

		/// <summary>
		/// Количество звонков для пополнения очереди
		/// </summary>
		public virtual int CallCount { get; set; }

		/// <summary>
		/// Длительность ожидания вызова
		/// </summary>
		public virtual int WaitTime { get; set; }

		/// <summary>
		/// Максимальное количество вызовов в очередь
		/// </summary>
		public virtual int CallMax { get; set; }
			
		/// <summary>
		/// Префикс
		/// </summary>
		public virtual string Prefix { get;set; }

		/// <summary>
		/// Идентификатор вызывающей стороны
		/// </summary>
		public virtual string CallerId { get; set; }

		/// <summary>
		/// Голосовая запись приветствия
		/// </summary>
		public virtual Vote VoteWelcome { get; set; }

		/// <summary>
		/// Голосовая запись завершения
		/// </summary>
		public virtual Vote VoteFinish { get; set; }

		/// <summary>
		/// Голосовая запись действия
		/// </summary>
		public virtual Vote VotePushTwo { get; set; }

		/// <summary>
		/// План входящих вызовов
		/// </summary>
		public virtual Dialplan DialplanIncoming { get; set; }

		/// <summary>
		/// План исходящих вызовов
		/// </summary>
		public virtual Dialplan DialplanOutgoining { get; set; }

		/// <summary>
		/// Конструктор
		/// </summary>
		public Trunk()
		{
		}

		/// <summary>
		/// Получает список рабочих каналов
		/// </summary>
		/// <returns></returns>
		public static async Task<IList<Trunk>> GetListAsync(TrunkRepository repository)
		{
			return await repository.GetListAsync();
		}

		/// <summary>
		/// Выполняет вызов исходящего номера телефона
		/// </summary>
		/// <param name="outgoing"></param>
		public virtual async Task DialingAsync(Outgoing outgoing, Setting setting, Config config, OutgoingRepository outgoingRepository)
		{
			string fileName = $"dial_{outgoing.Id}_{Title}_{outgoing.Telephone}.call";

			//outgoing.Telephone = "74443331100";

			string fullFileName = Path.GetTempPath() + fileName;

			outgoing.Normalize(config);
			
			using (var file =
				new StreamWriter(fullFileName, true))
			{
				await file.WriteLineAsync($"Channel: SIP/{Title}/{Prefix}{outgoing.Telephone}");
				await file.WriteLineAsync($"Callerid: {CallerId}");
				await file.WriteLineAsync($"MaxRetries: 0");
				await file.WriteLineAsync($"RetryTime: 20");
				await file.WriteLineAsync($"WaitTime: {WaitTime}");

				if (DialplanOutgoining != null)
					await file.WriteLineAsync($"Context: {DialplanOutgoining.Name}");
				else 
					await file.WriteLineAsync($"Context: {config.DefaultTrunkContext}");
				
				await file.WriteLineAsync($"Extension: s");
				await file.WriteLineAsync($"Priority: 1");

				if (config.IsVoteSupported && VoteWelcome != null && VotePushTwo != null && VoteFinish != null)
				{
					await file.WriteLineAsync($"Set: vote_welcome={VoteWelcome.Path.Replace(".mp3", "")}");

					await file.WriteLineAsync($"Set: vote_push_two={VotePushTwo.Path.Replace(".mp3", "")}");

					await file.WriteLineAsync($"Set: vote_finish={VoteFinish.Path.Replace(".mp3", "")}");
				}
			}

			/*
			File.Move(fullFileName, setting.OutgoingDir + "/" + fileName);
			*/

			/*
			string uri = $"http://ast11:3000/help/trank_check?id={this.Id}&telephone={outgoing.Telephone}&outgoing={outgoing.Id}";

			var result = await httpClient.GetAsync(uri);

			if (result.StatusCode != HttpStatusCode.OK)
			{
				throw new Exception(nameof(result));
			}

			*/

			/*
			OriginateAction oc = new OriginateAction
			{
				Channel = $"Channel: SIP/{Title}/{outgoing.Telephone}",
				Exten = "s",
				Priority = "1",
				CallerId = $"Callerid: {CallerId}",
				Context = "from-trunk",
				Timeout = WaitTime * 1000,
				Async = true
			};

			ManagerResponse originateResponse = managerConnection.SendAction(oc, oc.Timeout);
			*/

			
			var cmd = $"mv {fullFileName} {setting.OutgoingDir}";

			cmd.Bash();
			
			outgoing.Status = "DIALING";

			outgoing.Trunk = this;

			await outgoing.SaveAsync(outgoingRepository);
		}
	}
}
