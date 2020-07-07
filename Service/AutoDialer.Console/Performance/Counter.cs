using NLog;
using System;
using System.Collections.Generic;
using System.Text;

namespace AutoDialer.Console.Performance
{
	/// <summary>
	/// Счётчик производительности
	/// </summary>
	public class Counter
	{
		private const string Format = "COUNTER: {0,10}: {1,5}: {2}";

		/// <summary>
		/// Точка старта 
		/// </summary>
		private DateTime _startDate;

		/// <summary>
		/// Точка завершения
		/// </summary>
		private DateTime _endDate;

		/// <summary>
		/// Имя счётчика
		/// </summary>
		private string _name;

		/// <summary>
		/// Описание счётчика
		/// </summary>
		private string _description;

		/// <summary>
		/// Логирование
		/// </summary>
		private Logger _logger;

		/// <summary>
		/// Количество милисекунд работы счётчика
		/// </summary>
		public double TotalMilliseconds => (_endDate - _startDate).TotalMilliseconds;

		/// <summary>
		/// Конструктор
		/// </summary>
		/// <param name="name">Имя счётчика</param>
		/// <param name="description">Описание счётчика</param>
		/// <param name="logger">Логирование</param>
		public Counter(string name, string description, Logger logger)
		{
			_name = name;

			_description = description;

			_logger = logger ?? throw new ArgumentNullException(nameof(logger));
		}

		/// <summary>
		/// Начало измерения
		/// </summary>
		public void Start()
		{
			_startDate = DateTime.Now;

			_endDate = DateTime.Now;
		}

		/// <summary>
		/// Завершения измерения
		/// </summary>
		public void Stop()
		{
			_endDate = DateTime.Now;

			Log();
		}

		/// <summary>
		/// Выполняет протоколирование
		/// </summary>
		private void Log()
		{
			string msg = String.Format(Format, _name, TotalMilliseconds, _description);

			_logger.Debug(msg);

			System.Console.WriteLine(msg);
		}
	}
}
