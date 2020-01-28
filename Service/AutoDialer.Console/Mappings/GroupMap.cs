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
			Map(x => x.CarouselType).CustomType<CarouselTypeEnum>().Column("carousel_type");
			HasManyToMany(x => x.Trunks)
				.Cascade.All()
				.Inverse()
				.Table("groups_tranks")
				.ChildKeyColumn("trank_id")
				.ParentKeyColumn("group_id");
		}
	}
}
