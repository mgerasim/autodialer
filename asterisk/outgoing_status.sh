#!/bin/bash

AUTODIALER_ROOT="/home/rails/projects/autodialer"

/bin/mysql --user=avtodialer --password=avtodialer avtodialerdb_prod -e 'INSERT INTO answers(created_at, updated_at, contact, level, trank_id) VALUES(NOW(), NOW(), '$1', '$2', (SELECT id FROM tranks WHERE name='$3' LIMIT 1)) ON DUPLICATE KEY UPDATE created_at=NOW(), level='$2', trank_id=((SELECT id FROM tranks WHERE name='$3' LIMIT 1))'

