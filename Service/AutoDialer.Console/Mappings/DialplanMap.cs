using System;
using AutoDialer.Console.Models;
using FluentNHibernate.Mapping;

namespace AutoDialer.Console.Mappings
{
    public class DialplanMap: ClassMap<Dialplan>
    {
        public DialplanMap()
        {
            Table("dialplans");
            Id(x => x.Id).GeneratedBy.Increment().Not.Nullable().Length(6).Column("Id");
            Map(x => x.CreatedAt).Column("created_at");
            Map(x => x.UpdatedAt).Column("updated_at");
            Map(x => x.Title).Not.Nullable().Column("title");
            Map(x => x.Name).Not.Nullable().Column("name");
        }
    }
}
