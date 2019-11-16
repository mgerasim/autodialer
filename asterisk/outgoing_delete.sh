#!/bin/bash

AUTODIALER_ROOT="/home/rails/projects/autodialer"

echo "'DELETE FROM outgoings WHERE telephone like '%$1%''"

/bin/mysql --user=avtodialer --password=avtodialer avtodialerdb_prod -e "DELETE FROM outgoings WHERE telephone like '%$1%'"  >> /tmp/outgoing_delete_log.log 2>&1


