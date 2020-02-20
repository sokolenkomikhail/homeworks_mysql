#!/bin/bash
mysqldump example > ~/example.dump.sql
mysql sample < ~/example.dump.sql
