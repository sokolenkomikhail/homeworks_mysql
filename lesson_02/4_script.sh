#!/bin/bash
mysqldump --where="1 LIMIT 100" mysql --tables help_keyword > ~/mydump.sql
