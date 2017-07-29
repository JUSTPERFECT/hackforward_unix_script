
#!/bin/bash
# Unix Time Stamp
LOG_TIMESTAMP=$(date +"%Y%m%d-%H%M")
# Log Directory
LOG_DIR=/var/log/public-instance
# Create if not exist
mkdir -p $LOG_DIR

#Check Disk Space
df -h > $LOG_DIR/disk_$LOG_TIMESTAMP.log
#Check Free Memory
free -m > $LOG_DIR/memory_$LOG_TIMESTAMP.log
#Check VMStatistics
vmstat > $LOG_DIR/vmstat_$LOG_TIMESTAMP.log
#Check Network Statistics
netstat> $LOG_DIR/netstat_$LOG_TIMESTAMP.log
#Check all Running Processes
ps aux> $LOG_DIR/process_$LOG_TIMESTAMP.log

# Zip, Encrypt and enable Password Protection
zip -er -P accenturehack  $LOG_TIMESTAMP.zip $LOG_DIR/*

# Copying ZIP File to S3 Buckcet
aws s3 cp $LOG_TIMESTAMP.zip s3://hackforward-aws-2017

# Clear Logs
rm /var/log/public-instance/*.log