#!/bin/bash

AUTODIALER_ROOT="/home/rails/projects/autodialer"

/bin/mysql --user=avtodialer --password=avtodialer avtodialerdb_prod -e 'UPDATE outgoings SET REASON='$1' WHERE id='$2'

