#Linux Cluster Monitoring Agent

##*Introduction*
The sole purpose of the Linux Cluster Monitoring Agent is to provide users the capabilities to store and analyze 
system metrics in order to monitor system performance in an effective manner.
Through having hardware specifications and resource usage data processed and updated using various bash scripts to obtain
required data from each distinct node, and store the data into established database found in the main node,
this provides the user the ability to access this essential data efficiently, to be able
to address any issues directly. All gathered data is stored within a PostgreSQL database
curated to centralize data across numerous of cluster nodes. 

Technologies and software used throughout this process include: Google Cloud Platform, Git, VNC Server/Viewer, Linux CentOS 7, 
PostgreSQL, Docker, IntelliJ IDEA v2021.2.3, Bash Scripts, Crontab, and SQL Queries.

##*Quick Start*
- Start a PSQL instance using psql_docker.sh.
```
./scripts/psql_docker.sh start
```
- Create tables using ddl.sql.
```
psql -h localhost -U postgres -d host_agent -f sql/ddl.sql
```
- Insert hardware specs data into the DB using host_info.sh.
```
./scripts/host_info.sh psql_port db_name psql_user psql_password
```
- Insert hardware usage data into the DB using host_usage.sh.
```
./scripts/host_usage.sh psql_port db_name psql_user psql_password
```
- Crontab setup.
```
crontab -e
* * * * * bash /home/centos/dev/jarvis_data_eng_JoelAttalla/linux_sql/scripts/host_usage.sh localhost 5432 host_agent postgres password &> /tmp/host_usage.log
```

##*Implementation*
The project implementation process began with fully understanding the overall design 
and architecture, and identify the purpose of each file being created throughout the 
file directory. By understanding the purpose of each and every process throughout the 
project, will provide an accurate representation of how the final product should look. 
Following this, we continue on to provisioning a PSQL instance using Docker and installing
the PSQL CLI client tool, to ensure we are equipped with the necessary tools to commence with 
the development process. Once this was complete, we began the development process. Beginning with
writing bash scripts to create containers, collect and process system performance data,
store the collected data in assigned databases, implement monitoring programs to
continuously collect resource data usage and hardware specifications across servers. Lastly,
we have incorporated compiled SQL Queries to organize data clusters and combat any errors that
may arise throughout the deployment process. We will discuss the 
###Architecture

###Scripts
psql_docker.sh <br />
host_info.sh <br />
host_usage.sh <br />
crontab <br />
queries.sql <br />
###Database Modeling

##*Test*

##*Deployment*

##*Improvements*