using AutoDialer.Console.Models;
using AutoDialer.Console.Repositories.Base;
using NHibernate;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace AutoDialer.Console.Repositories
{
	public class VoteRepository : BaseRepository<Vote>
	{
		public VoteRepository(ISession session) : base(session)
		{
		}

		public override Task DeleteAsync(Vote entity)
		{
			throw new NotImplementedException();
		}

		public override Task<Vote> GetAsync(int Id)
		{
			throw new NotImplementedException();
		}

		public override async Task<IList<Vote>> GetListAsync()
		{
			var criteria = _session.CreateCriteria<Vote>();

			return await criteria.ListAsync<Vote>();
		}

		public override Task SaveAsync(Vote entity)
		{
			throw new NotImplementedException();
		}
	}
}
