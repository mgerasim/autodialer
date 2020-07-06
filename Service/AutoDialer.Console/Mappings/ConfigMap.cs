using System;
using AutoDialer.Console.Models;
using FluentNHibernate.Mapping;

namespace AutoDialer.Console.Mappings
{
    public class ConfigMap: ClassMap<Config>
    {
        public ConfigMap()
        {
            Table("configs");
            Id(x => x.Id).GeneratedBy.Increment().Not.Nullable().Length(6).Column("id");
            Map(x => x.CreatedAt).Column("created_at");
            Map(x => x.UpdatedAt).Column("updated_at");
            Map(x => x.ContryPrefix).Column("prefix_contry");
			Map(x => x.DefaultTrunkContext).Column("default_trank_context");
			Map(x => x.IsOutgoingDeleted).Not.Nullable().Column("is_outgoing_deleted");
            Map(x => x.IsVoteSupported).Not.Nullable().Column("is_vote_supported");
        }
    }
}
