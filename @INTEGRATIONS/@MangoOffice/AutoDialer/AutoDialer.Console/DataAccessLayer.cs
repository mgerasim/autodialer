using System;
using System.Reflection;
using FluentNHibernate.Cfg;
using FluentNHibernate.Cfg.Db;
using NHibernate;

namespace AutoDialer.Console
{
    /// <summary>
    /// Уровень доступа к данным
    /// </summary>
    public class DataAccessLayer: IDisposable
    {
        private ISessionFactory SessionFactory { get; set; }

        public DataAccessLayer(string connectionString)
        {
            CreateSessionFactory(connectionString);
        }

        public void CreateSessionFactory(string connectionString)
        {
            SessionFactory = Fluently.Configure()
                .Database(MySQLConfiguration.Standard
                    .ConnectionString(connectionString))
                .Mappings(m => m.FluentMappings.AddFromAssembly(Assembly.GetExecutingAssembly()))
                .BuildSessionFactory();
        }

        public ISession Open()
        {
            return SessionFactory.OpenSession();
        }

        public void Dispose()
        {
            SessionFactory.Close();
            SessionFactory.Dispose();
        }
    }
}
