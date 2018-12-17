/bin/mysql --user=avtodialer --password=avtodialer  avtodialerdb -e "INSERT INTO spools(outgoing_id) VALUES ('$1')"  >> /tmp/spool_log.log 2>&1
