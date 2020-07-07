using System;
namespace AutoDialer.Console.Models.Base
{
    /// <summary>
    /// Базовый класс записи
    /// </summary>
    public class Record
    {
        /// <summary>
        /// Идентификатор записи
        /// </summary>
        public virtual int Id { get; set; }

        /// <summary>
        /// Конструктор
        /// </summary>
        public Record()
        {
        }
    }
}
