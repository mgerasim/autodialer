using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoDialer.Console.Models;
using AutoDialer.Console.Repositories.Base;
using NHibernate;

namespace AutoDialer.Console.Repositories
{
    public class ConfigRepository : BaseRepository<Config>
    {
        public ConfigRepository(ISession session): base(session)
        {
        }

        public override Task DeleteAsync(Config entity)
        {
            throw new NotImplementedException();
        }

        public override Task<Config> GetAsync(int Id)
        {
            throw new NotImplementedException();
        }

        public override async Task<IList<Config>> GetListAsync()
        {
            var criteria = _session.CreateCriteria<Config>();

            return await criteria.ListAsync<Config>();
        }

        public override Task SaveAsync(Config entity)
        {
            throw new NotImplementedException();
        }
    }
}
