using System;
using NHibernate;

namespace AutoDialer.Console.DataAccessLayers
{
    /// <summary>
    /// Интерфейс уровня доступа к данным
    /// </summary>
    public interface IDataAccessLayer
    {
        void CreateSessionFactory(string connectionString);

        ISession Open();
    }
}
