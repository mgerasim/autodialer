using System;
using AutoDialer.Console.Models;
using FluentNHibernate.Mapping;

namespace AutoDialer.Console.Mappings
{
    public class SettingMap: ClassMap<Setting>
    {
        public SettingMap()
        {
            Table("settings");
            Id(x => x.Id).GeneratedBy.Increment().Not.Nullable().Length(6).Column("id");
            Map(x => x.CreatedAt).Column("created_at");
            Map(x => x.UpdatedAt).Column("updated_at");
            Map(x => x.HourBgn).Not.Nullable().Column("hour_bgn");
            Map(x => x.HourEnd).Not.Nullable().Column("hour_end");
            Map(x => x.OutgoingDir).Not.Nullable().Column("outgoing");
            Map(x => x.DialType).CustomType<SettingDialType>().Not.Nullable().Column("dialtype");
        }
    }
}
