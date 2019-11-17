using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using AutoDialer.Console;
using FluentNHibernate.Cfg;
using FluentNHibernate.Cfg.Db;

namespace AutoDialer
{
    class Program
    {
        static async Task Main()
        {
            DataAccessLayer dataAccessLayer = null;

            try
            {
                var connectionString = "";

                dataAccessLayer = new DataAccessLayer(connectionString);

                dataAccessLayer.Open();

                do
                {
                    await Task.Delay(1000);
                } while (false);

            }
            catch(Exception exc)
            {
                System.Console.Write(exc.ToString());
            }
            finally
            {
                if (dataAccessLayer != null)
                {
                    dataAccessLayer.Dispose();
                }
            }
            
        }

        
    }
}
