using System;
using AutoDialer.Console.Models.Base;

namespace AutoDialer.Console.Models
{
    /// <summary>
    /// Рабочий канал
    /// </summary>
    public class Trunk: Record
    {
        /// <summary>
        /// Наименование
        /// </summary>
        public virtual string Title { get; set; }

        /// <summary>
        /// Конструктор
        /// </summary>
        public Trunk()
        {
        }
    }
}
