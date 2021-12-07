#Linux Cluster Monitoring Agent
##*Introduction*
The sole purpose of the Linux Cluster Monitoring Agent is to provide users the capabilities to store and analyze 
system metrics in order to monitor system performance in an effective manner.
Through having hardware specifications and resource usage data processed using various bash scripts to obtain
required data and store the data into established databases,
this provides user the ability to access this essential data efficiently, to be able
to address any issues directly. All gathered data is stored within a PostgreSQL database
curated to centralize data across numerous of cluster nodes. Technologies used throughout this process include, bash
scripts, enabling various of commands to obtain, process, and store data, 

##*Quick Start*
```
psql_docker.sh - docker container start jrvs-psql
ddl.sql - 
host_info.sh - 
host_usage.sh - 
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
may arise throughout the deployment process.
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