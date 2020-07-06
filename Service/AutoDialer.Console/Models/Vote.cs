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
    /// Звуковая запись
    /// </summary>
    public class Vote: Record
    {
        /// <summary>
        /// Наименование
        /// </summary>
        public virtual string Title { get; set; }

        /// <summary>
        /// Имя файла
        /// </summary>
        public virtual string FileName { get; set; }

        /// <summary>
        /// Тип файла
        /// </summary>
        public virtual string ContentType { get; set; }

        /// <summary>
        /// Размер файла
        /// </summary>
        public virtual int FileSize { get; set; }

        /// <summary>
        /// Полный путь к звуковой записи
        /// </summary>
        public virtual string Path => string.Format($"/home/rails/projects/autodialer/public/system/votes/records/000/000/{Id.ToString("D3")}/original/{FileName}");

        /// <summary>
        /// Конструктор
        /// </summary>
        public Vote()
        {
        }

        /// <summary>
        /// Получает список звуковых записей
        /// </summary>
        /// <returns></returns>
        public static async Task<IList<Vote>> GetListAsync(VoteRepository repository)
        {
            return await repository.GetListAsync();
        }

    }
}
