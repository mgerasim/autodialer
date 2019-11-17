using System;
namespace AutoDialer.Console.Models
{
    /// <summary>
    /// Службы генерации вызовов на обзвон
    /// </summary>
    public enum SettingDialType
    {
        /// <summary>
        /// Первоначальный синхронная (последовательная) версия, разработанная на Ruby как rake-задача
        /// </summary>
        DialSyncRuby = 1,

        /// <summary>
        /// Обновленная асинхронная версия, разработанная на CSharp и оформленна как demon-служба (текущая реализация)
        /// </summary>
        DialAsyncCSharp = 2
    }
}
