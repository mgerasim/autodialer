using System;
using AutoDialer.Console.Models;
using FluentNHibernate.Mapping;

namespace AutoDialer.Console.Mappings
{
    public class TrunkMap: ClassMap<Trunk>
    {
        public TrunkMap()
        {
            Table("trunks");
            Id(x => x.Id).GeneratedBy.Increment().Not.Nullable().Length(6).Column("Id");
            Map(x => x.Title).Not.Nullable().Column("name");
        }
    }
}
