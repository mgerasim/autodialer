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

            using (var tran = _session.BeginTransaction()) {

                var criteria = _session.CreateCriteria<Setting>();

                var list = await criteria.ListAsync<Setting>();

                await tran.CommitAsync();

                return list;
            }
    
        }

        public override Task SaveAsync(Setting entity)
        {
            throw new NotImplementedException();
        }
    }
}
