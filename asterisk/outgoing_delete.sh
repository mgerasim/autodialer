#!/bin/bash

AUTODIALER_ROOT="/home/rails/projects/autodialer"

/bin/mysql --user=avtodialer --password=avtodialer avtodialerdb_prod -e 'DELETE FROM outgoings WHERE telephone like "%$1%"'


