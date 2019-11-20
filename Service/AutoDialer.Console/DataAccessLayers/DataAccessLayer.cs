using System;
using System.Reflection;
using AutoDialer.Console.DataAccessLayers;
using FluentNHibernate.Cfg;
using FluentNHibernate.Cfg.Db;
using MySql.Data.MySqlClient;
using NHibernate;

namespace AutoDialer.Console
{
    public class OdbcConfiguration :
    PersistenceConfiguration<OdbcConfiguration,
        FluentNHibernate.Cfg.Db.OdbcConnectionStringBuilder>
    {
        protected OdbcConfiguration()
        {
            Driver<NHibernate.Driver.OdbcDriver>();
        }

        public static OdbcConfiguration MyDialect // <-- insert any name here
        {
            get
            {
                // insert the dialect you want to use
                return new OdbcConfiguration().Dialect<NHibernate.Dialect.MySQLDialect>();
            }
        }
    }

    /// <summary>
    /// Уровень доступа к данным
    /// </summary>
    public class DataAccessLayer: IDataAccessLayer, IDisposable
    {
        //string _connectionString = "Server=185.20.225.203;Database=avtodialerdb_prod;UserId=avtodialer;password=avtodialer;";
        //string _connectionString = "Server=localhost; Database=avtodialerdb_prod; UserId=avtodialer; password=avtodialer; Protocol=Unix;";
        string _connectionString = "Driver={MySQL ODBC 5.2 ANSI Driver};Server=localhost;Database=avtodialerdb_prod;User=avtodialer;Password=avtodialer;Option=3;";
        private ISessionFactory SessionFactory { get; set; }

        public DataAccessLayer()
        {
            CreateSessionFactory(_connectionString);
        }

        public void CreateSessionFactory(string connectionString)
        {
            MySqlConnectionStringBuilder conn_string = new MySqlConnectionStringBuilder();
            conn_string.Server = "ast11";
            conn_string.UserID = "avtodialer";
            conn_string.Password = "avtodialer";
			conn_string.Port = 3306;
            conn_string.Database = "avtodialerdb_prod"; // "avtodialerdb_prod";
            conn_string.AllowZeroDateTime = true;
            conn_string.ConvertZeroDateTime = true;

            conn_string.Logging = true;

       
            SessionFactory = Fluently.Configure()
                .Database(MySQLConfiguration.Standard 
                    .ConnectionString(conn_string.ToString())
                    .Driver<NHibernate.Driver.MySqlDataDriver>)
                .Mappings(m => m.FluentMappings.AddFromAssembly(Assembly.GetExecutingAssembly()))
                .BuildSessionFactory();
			/*
#else
            
            SessionFactory = Fluently.Configure()
                .Database(OdbcConfiguration.MyDialect.ConnectionString("DSN=ODBC2;UID=avtodialer;PWD=avtodialer")
                        .Driver<NHibernate.Driver.OdbcDriver>()
                        .Dialect<NHibernate.Dialect.MySQLDialect>()

                        ).Mappings(m => m.FluentMappings.AddFromAssembly(Assembly.GetExecutingAssembly()))
                           .BuildSessionFactory() // <-- again, change this
                        ;

#endif
			*/
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
