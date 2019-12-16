using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoDialer.Console.Models;
using AutoDialer.Console.Repositories.Base;
using NHibernate;

namespace AutoDialer.Console.Repositories
{
    public class DialplanRepository: BaseRepository<Dialplan>
    {
        public DialplanRepository(ISession session): base(session)
        {
        }

        public override Task DeleteAsync(Dialplan entity)
        {
            throw new NotImplementedException();
        }

        public override Task<Dialplan> GetAsync(int Id)
        {
            throw new NotImplementedException();
        }

        public override async Task<IList<Dialplan>> GetListAsync()
        {
            var criteria = _session.CreateCriteria<Dialplan>();

            return await criteria.ListAsync<Dialplan>();
        }

        public override Task SaveAsync(Dialplan entity)
        {
            throw new NotImplementedException();
        }
    }
}
