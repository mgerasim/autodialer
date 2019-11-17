using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using NHibernate;

namespace AutoDialer.Console.Repositories.Base
{
    /// <summary>
    /// Реализация базовых функций интерфейса репозитория
    /// </summary>
    abstract public class BaseRepository<T>: IRepository<T>
    {
        /// <summary>
        /// Уровень доступа к данным
        /// </summary>
        protected DataAccessLayer _dataAccessLayer;

        /// <summary>
        /// Сессия соединения с БД
        /// </summary>
        protected ISession _session;

        /// <summary>
        /// Конструктор
        /// </summary>
        protected BaseRepository()
        {
            _dataAccessLayer = new DataAccessLayer();

            _session = _dataAccessLayer.Open();
        }

        abstract public Task DeleteAsync(T entity);

        abstract public Task<T> GetAsync(int Id);

        abstract public Task<IList<T>> GetListAsync();

        abstract public Task SaveAsync(T entity);
    }
}
