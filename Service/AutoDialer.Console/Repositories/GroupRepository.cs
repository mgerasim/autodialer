using AutoDialer.Console.Models;
using AutoDialer.Console.Repositories.Base;
using NHibernate;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace AutoDialer.Console.Repositories
{
	public class GroupRepository : BaseRepository<Group>
	{
		public GroupRepository(ISession session) : base(session)
		{
		}

		public override Task DeleteAsync(Group entity)
		{
			throw new NotImplementedException();
		}

		public override Task<Group> GetAsync(int Id)
		{
			throw new NotImplementedException();
		}

		public override async Task<IList<Group>> GetListAsync()
		{
			var criteria = _session.CreateCriteria<Group>();

			return await criteria.ListAsync<Group>();
		}

		public override Task SaveAsync(Group entity)
		{
			throw new NotImplementedException();
		}
	}
}
