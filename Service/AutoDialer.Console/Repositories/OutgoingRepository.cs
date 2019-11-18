using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoDialer.Console.Models;
using AutoDialer.Console.Repositories.Base;
using NHibernate.Criterion;

namespace AutoDialer.Console.Repositories
{
    public class OutgoingRepository : BaseRepository<Outgoing>
    {
        public OutgoingRepository()
        {
        }

        /// <summary>
        /// Удаляет запись объекта
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public override async Task DeleteAsync(Outgoing entity)
        {
			_session.BeginTransaction();

			await _session.DeleteAsync(entity);

			await _session.Transaction.CommitAsync();
        }

        public override Task<Outgoing> GetAsync(int Id)
        {
            throw new NotImplementedException();
        }

        public override async Task<IList<Outgoing>> GetListAsync()
        {
            var criteria = _session.CreateCriteria<Outgoing>();

            return await criteria.ListAsync<Outgoing>();
        }

        public override Task SaveAsync(Outgoing entity)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// Возвращает исходящие номера телефонов со статусом INSERTED для обзвона
        /// </summary>
        /// <returns></returns>
        public async Task<IList<Outgoing>> GetInsertedListAsync()
        {
            var criteria = _session.CreateCriteria<Outgoing>()
                .Add(Restrictions.Eq(nameof(Outgoing.Status), "INSERTED"))
                ;

            return await criteria.ListAsync<Outgoing>();
        }

        /// <summary>
        /// Возвращает исходящие номера телефонов со статусом INSERTED для обзвона
        /// </summary>
        /// <returns></returns>
        public async Task<IList<Outgoing>> GetInsertedListAsync(int maxResult)
        {
            var criteria = _session.CreateCriteria<Outgoing>()
                .Add(Restrictions.Eq(nameof(Outgoing.Status), "INSERTED"))
                .SetMaxResults(maxResult)
                ;

            return await criteria.ListAsync<Outgoing>();
        }
    }
}
