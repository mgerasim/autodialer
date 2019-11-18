using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace AutoDialer.Console.Repositories.Base
{
    /// <summary>
    /// Интерфейс репозитория
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public interface IRepository<T>
    {
        /// <summary>
        /// Получение объекта по идентификатору
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        Task<T> GetAsync(int Id);

        /// <summary>
        /// Получение списка объектов
        /// </summary>
        /// <returns></returns>
        Task<IList<T>> GetListAsync();

        /// <summary>
        /// Создание нового объекта или обновление текущего
        /// </summary>
        /// <param name="entity"></param>
        Task SaveAsync(T entity);

        /// <summary>
        /// Удаление объекта
        /// </summary>
        /// <param name="entity"></param>
        Task DeleteAsync(T entity);
    }
}
