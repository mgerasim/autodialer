using System;
using AutoDialer.Console.Models;
using FluentNHibernate.Mapping;

namespace AutoDialer.Console.Mappings
{
	public class GroupMap: ClassMap<Group>
	{
		public GroupMap()
		{
			Table("groups");
			Id(x => x.Id).GeneratedBy.Increment().Not.Nullable().Length(6).Column("Id");
			Map(x => x.CreatedAt).Column("created_at");
			Map(x => x.UpdatedAt).Column("updated_at");
			Map(x => x.Title).Not.Nullable().Column("title");
			Map(x => x.Actived).Not.Nullable().Column("is_enabled");
			Map(x => x.CallCount).Not.Nullable().Column("callcount");
			Map(x => x.WaitTime).Not.Nullable().Column("waittime");
			Map(x => x.CallMax).Not.Nullable().Column("callmax");
			HasManyToMany(x => x.Trunks)
				.Cascade.All()
				.Inverse()
				.Table("groups_tranks")
				.ParentKeyColumn("trank_id");
		}
	}
}
