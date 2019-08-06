/bin/mysql --user=avtodialer --password=avtodialer  avtodialerdb -e "INSERT INTO machines(telephone, amdstatus, amdcause) VALUES ('$1', '$2', '$3')"  >> /tmp/machine_log.log 2>&1

