using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoDialer.Console.Models.Base;
using AutoDialer.Console.Repositories;

namespace AutoDialer.Console.Models
{
    /// <summary>
    /// Исходящие номера телефонов
    /// </summary>
    public class Outgoing: Record
    {
		private string _telephone;

        /// <summary>
        /// Рабочий канал с которого произошел вызов
        /// </summary>
         public virtual Trunk Trunk { get; set; }

        /// <summary>
        /// Номер телефона
        /// </summary>
        public virtual string Telephone
		{
			get => _telephone;
			set => _telephone = value.Trim().Replace("\n", "").Replace("\r", "");
		}

        /// <summary>
        /// Статус телефонного номера
        /// </summary>
        public virtual string Status { get; set; }

        /// <summary>
        /// Конструктор
        /// </summary>
        public Outgoing()
        {
        }

		/// <summary>
		/// Нормализация телефонного номера
		/// </summary>
		/// <param name="config"></param>
		public virtual void Normalize(Config config)
		{
			if (!string.IsNullOrEmpty(_telephone))
			{
				string reverseTelephone = Outgoing.Reverse(_telephone);

				reverseTelephone = reverseTelephone.Substring(0, 10);

				_telephone = $"{config.ContryPrefix}{Outgoing.Reverse(reverseTelephone)}";
			}
		}

        /// <summary>
        /// Получает список всех номеров
        /// </summary>
        /// <returns></returns>
        public static async Task<IList<Outgoing>> GetListAsync(OutgoingRepository repository)
        {
            return await repository.GetListAsync();
        }

        /// <summary>
        /// Получает список номеров для обзвона
        /// </summary>
        /// <returns></returns>
        public static async Task<IList<Outgoing>> GetInsertedListAsync(OutgoingRepository repository)
        {
            return await repository.GetInsertedListAsync();
        }

        /// <summary>
        /// Получает список номеров для обзвона
        /// </summary>
        /// <returns></returns>
        public static async Task<IList<Outgoing>> GetInsertedListAsync(OutgoingRepository repository, int maxResult)
        {
            return await repository.GetInsertedListAsync(maxResult);
        }

        /// <summary>
        /// Удаляет запись 
        /// </summary>
        /// <returns></returns>
        public virtual async Task DeleteAsync(OutgoingRepository repository)
        {
            await repository.DeleteAsync(this);
        }

        /// <summary>
        /// Обновляет или сохраняет запись
        /// </summary>
        /// <returns></returns>
        public virtual async Task SaveAsync(OutgoingRepository repository)
        {
            UpdatedAt = DateTime.Now;

            await repository.SaveAsync(this);
        }
				
		public static string Reverse(string s)
		{
			char[] charArray = s.ToCharArray();
			Array.Reverse(charArray);
			return new string(charArray);
		}
	}
}
