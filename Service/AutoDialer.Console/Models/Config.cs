using AutoDialer.Console.Models.Base;
using AutoDialer.Console.Repositories;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace AutoDialer.Console.Models
{
	/// <summary>
	/// Конфигурация приложения
	/// </summary>
	public class Config: Record
    {
		/// <summary>
		/// Телефонный префикс для страны
		/// </summary>
		public virtual int ContryPrefix { get; set; } = 7;

		/// <summary>
		/// Удалять исходящие после вызова
		/// </summary>
		public virtual bool IsOutgoingDeleted { get; set; }

		/// <summary>
		/// Контекст по умолчанию для вызова
		/// </summary>
		public virtual string DefaultTrunkContext { get; set; }
		
		/// <summary>
		/// Конструктор
		/// </summary>
		public Config()
        {

        }

		/// <summary>
		/// Перечитывает конфигурацию
		/// </summary>
		/// <returns></returns>
		public static async Task<Config> Reload(ConfigRepository repository)
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
