#!/bin/bash
############################################################################
#
# PostgreSQL Database Backup To Amazon S3 From AWS EC2 Instance
# Written By : Mohammad Samsad Hussain
#
############################################################################

DATE=$(date +'%d_%m_%Y')
# PostgreSQL Database server credentials
PG_DB_HOST="ip-172-31-10-232.us-west-2.compute.internal"
PG_DB_PORT="5432"
PG_DB_USER="postgres"
PG_DB_PASS="Postgres#5432"
DB_NAME="postgres pg1 pg2"
# Local Backup Directory
LOCAL_BACKUP_PATH="/PG_BACKUP"
# AWS S3 Bucket Path
S3_BUCKET_NAME="s3bucket687310"
S3_BUCKET_PATH="DB_BACKUP"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
##################### Database Backup Execution Script ######################
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
for database in $DB_NAME; do
PG_PASSWORD=${PG_DB_PASS} pg_dump \
--host=${PG_DB_HOST} \
--port=${PG_DB_PORT} \
--username=${PG_DB_USER} \
${database} | gzip > ${LOCAL_BACKUP_PATH}/${database}-$DATE.sql.gz
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
##################### Upload Database Backup To S3 Bucket ######################
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
aws s3 cp ${LOCAL_BACKUP_PATH}/${database}-$DATE.sql.gz
s3://${S3_BUCKET_NAME}/${S3_BUCKET_PATH}/
done