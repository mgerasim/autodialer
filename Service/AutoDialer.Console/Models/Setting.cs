using System;
using System.Linq;
using System.Threading.Tasks;
using AutoDialer.Console.Models.Base;
using AutoDialer.Console.Repositories;

namespace AutoDialer.Console.Models
{
    /// <summary>
    /// Настройки приложения
    /// </summary>
    public class Setting: Record
    {
        /// <summary>
        /// Час начало работы
        /// </summary>
        public virtual int HourBgn { get; set; }

        /// <summary>
        /// Час завершения работы
        /// </summary>
        public virtual int HourEnd { get; set; }

        /// <summary>
        /// Каталог исходящих
        /// </summary>
        public virtual string OutgoingDir { get; set; }

        /// <summary>
        /// Тип службы генерации вызовов на обзвон
        /// </summary>
        public virtual SettingDialType DialType { get; set; }

        /// <summary>
        /// Конструктор
        /// </summary>
        public Setting()
        {

        }

        /// <summary>
        /// Перечитывает настройки
        /// </summary>
        /// <returns></returns>
        public static async Task<Setting> Reload(SettingRepository repository)
        {
            var list = await repository.GetListAsync();

            if (list.Count == 0)
            {
                throw new NullReferenceException(nameof(list));
            }

            return list.First();
        }
    }
}
