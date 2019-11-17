using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoDialer.Console.Models;
using AutoDialer.Console.Repositories.Base;

namespace AutoDialer.Console.Repositories
{
    public class TrunkRepository: BaseRepository<Trunk>
    {
        public TrunkRepository()
        {
        }

        public override Task DeleteAsync(Trunk entity)
        {
            throw new NotImplementedException();
        }

        public override Task<Trunk> GetAsync(int Id)
        {
            throw new NotImplementedException();
        }

        public override async Task<IList<Trunk>> GetListAsync()
        {
            var criteria = _session.CreateCriteria<Trunk>();

            return await criteria.ListAsync<Trunk>();
        }

        public override Task SaveAsync(Trunk entity)
        {
            throw new NotImplementedException();
        }
    }
}
