/bin/mysql --user=avtodialer --password=avtodialer avtodialerdb -e "INSERT INTO spools(outgoing_id, trank_id) VALUES ('$1', '$2')"  >> /tmp/spool_log.log 2>&1
