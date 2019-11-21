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
        /// Сессия соединения с БД
        /// </summary>
        protected ISession _session;

        /// <summary>
        /// Конструктор
        /// </summary>
        protected BaseRepository(ISession session)
        {
            _session = session ?? throw new ArgumentNullException(nameof(session));
        }

        abstract public Task DeleteAsync(T entity);

        abstract public Task<T> GetAsync(int Id);

        abstract public Task<IList<T>> GetListAsync();

        abstract public Task SaveAsync(T entity);
    }
}
