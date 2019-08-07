#!/bin/bash

AUTODIALER_ROOT="/home/rails/projects/autodialer"

/bin/mysql --user=avtodialer --password=avtodialer avtodialerdb_prod -e 'INSERT INTO answers(created_at, updated_at, contact, level) VALUES(NOW(), NOW(), '$1', '$2') ON DUPLICATE KEY UPDATE created_at=NOW(), level='$2''  >> $AUTODIALER_ROOT/log/outgoing_status.log 2>> $AUTODIALER_ROOT/log/outgoing_status_error.log


