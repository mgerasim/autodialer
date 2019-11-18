using System;
using AutoDialer.Console.Models;
using FluentNHibernate.Mapping;

namespace AutoDialer.Console.Mappings
{
    public class TrunkMap: ClassMap<Trunk>
    {
        public TrunkMap()
        {
            Table("tranks");
            Id(x => x.Id).GeneratedBy.Increment().Not.Nullable().Length(6).Column("Id");
            Map(x => x.Title).Not.Nullable().Column("name");
            Map(x => x.Actived).Not.Nullable().Column("enabled");
            Map(x => x.CallCount).Not.Nullable().Column("callcount");
            Map(x => x.WaitTime).Not.Nullable().Column("waittime");
            Map(x => x.CallMax).Not.Nullable().Column("callmax");
			Map(x => x.CallerId).Not.Nullable().Column("callerid");
        }
    }
}
