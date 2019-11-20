using System;
using AutoDialer.Console.Models;
using AutoDialer.Console.Models.Base;
using FluentNHibernate.Mapping;

namespace AutoDialer.Console.Mappings
{
    public class OutgoingMap: ClassMap<Outgoing>
    {
        public OutgoingMap()
        {
            Table("outgoings");
            Id(x => x.Id).GeneratedBy.Increment().Not.Nullable().Length(6).Column("id");
            Map(x => x.CreatedAt).Column("created_at");
            Map(x => x.UpdatedAt).Column("updated_at");
            Map(x => x.Telephone).Not.Nullable().Column("telephone");
            Map(x => x.Status).Not.Nullable().Column("status");
            References(x => x.Trunk).Column("trank_id");
        }
    }
}
