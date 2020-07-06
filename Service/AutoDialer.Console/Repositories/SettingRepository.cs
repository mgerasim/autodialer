using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoDialer.Console.Models;
using AutoDialer.Console.Repositories.Base;
using NHibernate;

namespace AutoDialer.Console.Repositories
{
    public class SettingRepository : BaseRepository<Setting>
    {
        public SettingRepository(ISession session): base(session)
        {
        }

        public override Task DeleteAsync(Setting entity)
        {
            throw new NotImplementedException();
        }

        public override Task<Setting> GetAsync(int Id)
        {
            throw new NotImplementedException();
        }

        public override async Task<IList<Setting>> GetListAsync()
        {
            var criteria = _session.CreateCriteria<Setting>();

            return await criteria.ListAsync<Setting>();
        }

        public override Task SaveAsync(Setting entity)
        {
            throw new NotImplementedException();
        }
    }
}
