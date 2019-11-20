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
        ///  Дата создания записи
        /// </summary>
        public virtual DateTime CreatedAt { get; set; } = DateTime.Now;

        /// <summary>
        /// Дата обновления записи
        /// </summary>
        public virtual DateTime UpdatedAt { get; set; } = DateTime.Now;

        /// <summary>
        /// Конструктор
        /// </summary>
        public Record()
        {
        }
    }
}
