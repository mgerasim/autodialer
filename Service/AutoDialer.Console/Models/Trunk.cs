using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using AutoDialer.Console.Models.Base;
using AutoDialer.Console.Repositories;

namespace AutoDialer.Console.Models
{
    /// <summary>
    /// Рабочий канал
    /// </summary>
    public class Trunk: Record
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
        /// Длительност ожидания вызова
        /// </summary>
        public virtual int WaitTime { get; set; }

        /// <summary>
        /// Маскимальное количество вызовов в очереде
        /// </summary>
        public virtual int CallMax { get; set; }

        /// <summary>
        /// Конструктор
        /// </summary>
        public Trunk()
        {
        }

        /// <summary>
        /// Получает список рабочих каналов
        /// </summary>
        /// <returns></returns>
        public static async Task<IList<Trunk>> GetListAsync()
        {
            var repository = new TrunkRepository();

            return await repository.GetListAsync();
        }

        /// <summary>
        /// Выполняет вызов исходящего номера телефона
        /// </summary>
        /// <param name="outgoing"></param>
        public virtual async Task Dialing(Outgoing outgoing, Setting setting)
        {
            string fileName = $"{Guid.NewGuid().ToString()}-{Title}-{outgoing.Telephone}.call";

            string fullFileName = Path.GetTempPath() + fileName;

            System.Console.WriteLine(fullFileName);

            using (var file =
            new System.IO.StreamWriter(fullFileName, true))
            {
                file.WriteLine($"Channel: SIP/{Title}/{outgoing.Telephone}");
                //file.WriteLine("Callerid: " + self.callerid)
                file.WriteLine("MaxRetries: 0");
                file.WriteLine("RetryTime: 20");
                file.WriteLine($"WaitTime: {WaitTime}");
                    /*
                    if (self.dialplan != nil)
                    f.puts("Context: " + self.dialplan.name)
                else
                    */
                file.WriteLine("Context: from-trunk");

                file.WriteLine("Extension: s");
                file.WriteLine("Priority: 1");


            }

            try
            {
                File.Move(fullFileName, setting.OutgoingDir + "/" + fileName);
            }
            catch { }
            finally { }

            await outgoing.DeleteAsync();
        }
    }
}
