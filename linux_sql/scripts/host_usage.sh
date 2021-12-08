#!/bin/bash

psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

<<<<<<< HEAD
if [ $# -ne 5 ]; then
  echo "Number of arguements invalid, 5 arguements (host, port, database name, user and password fields)
required to continue."
=======
if [ $# -ne  5 ]; then
  echo "  Number of arguements invalid."
  echo "  5 arguements (host, port, database name,
  user and password fields) required to continue."
>>>>>>> 5bd1ab3359140a74a61b51cf65e1012a7f4cd0ad
  exit 1
fi

vmstat_mb=$(vmstat --unit M)
hostname=$(hostname -f)

memory_free=$(echo "$vmstat_mb" | awk '{print $4}'| tail -n1 | xargs)
<<<<<<< HEAD
cpu_idle=$(echo "$vmstat_mb" | awk '{print $15}' | tail -1 | xargs) 
=======
cpu_idle=$(echo "$vmstat_mb" | awk '{print $15}' | tail -1 | xargs)
>>>>>>> 5bd1ab3359140a74a61b51cf65e1012a7f4cd0ad
cpu_kernel=$(echo "$vmstat_mb" | awk '{print $14}' | tail -1 | xargs)
disk_io=$(vmstat -d | awk '{print $10}' | tail -1 | xargs)
disk_available=$(df -BM / | awk '{print $4}' | tail -1 | xargs)
timestamp=$(vmstat -t | awk '{print $18" "$19}')

disk_available=$(echo "$disk_available" | sed 's/[A-Za-z]*//g')
timestamp=$(echo "$timestamp" | sed 's/[A-Za-z]*//g')

<<<<<<< HEAD
insert_stmt="INSERT INTO host_usage(timestamp,host_id, memory_free, cpu_idle, cpu_kernel, disk_io, disk_available) VALUES
('$timestamp',(SELECT id FROM host_info WHERE hostname='$hostname'), $memory_free, $cpu_idle, $cpu_kernel, $disk_io, $disk_available)"
=======
host_id="(SELECT id FROM host_info WHERE hostname='$hostname')";

insert_stmt="INSERT INTO host_usage (timestamp, host_id, memory_free, cpu_idle, cpu_kernel, disk_io, disk_available) VALUES('$timestamp', '$host_id','$memory_free','$cpu_idle','$cpu_kernel','$disk_io','$disk_available');"
>>>>>>> 5bd1ab3359140a74a61b51cf65e1012a7f4cd0ad

export PGPASSWORD=$psql_password 

psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
<<<<<<< HEAD

=======
>>>>>>> 5bd1ab3359140a74a61b51cf65e1012a7f4cd0ad
exit $?
