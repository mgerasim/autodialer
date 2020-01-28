using AutoDialer.Console.Models.Base;
using AutoDialer.Console.Repositories;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace AutoDialer.Console.Models
{
	/// <summary>
	/// Настройки приложения
	/// </summary>
	public class Group : Record
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
		/// Рабочие каналы в группе
		/// </summary>
		public virtual IList<Trunk> Trunks { get; set; }

		/// <summary>
		/// Конструктор
		/// </summary>
		public Group()
		{

		}

		/// <summary>
		/// Получает список рабочих каналов
		/// </summary>
		/// <returns></returns>
		public static async Task<IList<Group>> GetListAsync(GroupRepository repository)
		{
			return await repository.GetListAsync();
		}
	}
}