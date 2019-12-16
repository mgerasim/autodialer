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
            Map(x => x.CreatedAt).Column("created_at");
            Map(x => x.UpdatedAt).Column("updated_at");
            Map(x => x.Title).Not.Nullable().Column("name");
            Map(x => x.Actived).Not.Nullable().Column("enabled");
            Map(x => x.CallCount).Not.Nullable().Column("callcount");
            Map(x => x.WaitTime).Not.Nullable().Column("waittime");
            Map(x => x.CallMax).Not.Nullable().Column("callmax");
			Map(x => x.CallerId).Not.Nullable().Column("callerid");
            References(x => x.VoteWelcome).Column("vote_welcome_id");
            References(x => x.VotePushTwo).Column("vote_push_two_id");
            References(x => x.VoteFinish).Column("vote_finish_id");
			References(x => x.DialplanIncoming).Column("dialplan_incoming_id");
			References(x => x.DialplanOutgoining).Column("dialplan_id");
        }
    }
}
