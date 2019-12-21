using System;
using AutoDialer.Console.Models;
using FluentNHibernate.Mapping;

namespace AutoDialer.Console.Mappings
{
    public class VoteMap: ClassMap<Vote>
    {
        public VoteMap()
        {
            Table("votes");
            Id(x => x.Id).GeneratedBy.Increment().Not.Nullable().Length(6).Column("Id");
            Map(x => x.CreatedAt).Column("created_at");
            Map(x => x.UpdatedAt).Column("updated_at");
            Map(x => x.Title).Not.Nullable().Column("title");
            Map(x => x.FileName).Not.Nullable().Column("record_file_name");
            Map(x => x.ContentType).Not.Nullable().Column("record_content_type");
            Map(x => x.FileSize).Not.Nullable().Column("record_file_size");
        }
    }
}
