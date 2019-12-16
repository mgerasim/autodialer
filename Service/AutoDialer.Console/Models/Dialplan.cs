using System;
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
    /// Сценарий прохождения звонка
    /// </summary>
    public class Dialplan: Record
	{
		/// <summary>
		/// Описание сценария
		/// </summary>
		public virtual string Title { get; set; }

		/// <summary>
		/// Имя сценария
		/// </summary>
		public virtual string Name { get; set; }

		/// <summary>
		/// Конструктор
		/// </summary>
		public Dialplan()
        {
        }

        /// <summary>
        /// Получает список звуковых записей
        /// </summary>
        /// <returns></returns>
        public static async Task<IList<Dialplan>> GetListAsync(DialplanRepository repository)
        {
            return await repository.GetListAsync();
        }

    }
}
