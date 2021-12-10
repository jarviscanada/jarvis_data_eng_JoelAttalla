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
may arise throughout the deployment process. We will discuss the architecture design, description
and usage of each shell script, and the database modeling.

###Architecture
Shown through the diagram below, you can see a Linux cluster consisting of three Linux nodes defined
within the virtual machine interphase, consisting of bash script that is executed to collect and process
hardware info and usage. This data is then transmitted through an internal switch to the primary linux node 
consisting of a provisioned Postgres database. Data collected from the *host_info.sh* script will attain the
server host hardware specifications, and store them in the host_info table in the database once, whereas the 
*host_usage.sh* script will attain the server host usage data, and store them in the host_usage table on a 
minute by minute basis.

![Linux_SQL_Architecture](assets/Linux_SQL_Architecture.jpeg)

###Scripts
Below we will discuss each provisioned script each created to execute specific tasks that are essential in 
collecting the data we are seeking to analyze and store.

####psql_docker.sh

- Description <br />
This script will provide the ability to create a PSQL container, as well as start and stop
the created container. The script must pass through implemented parameters prior to creating 
the container, to ensure only one container is created.

- Usage <br />

```
./scripts/psql_docker.sh create "postgres" "password"
```

```
./scripts/psql_docker.sh start
```

```
./scripts/psql_docker.sh stop
```

####host_info.sh

- Description <br />

- Usage <br />

####host_usage.sh <br />

- Description <br />

- Usage <br />

####crontab <br />

- Description <br />

- Usage <br />

####queries.sql <br />

- Description <br />

- Usage <br />

###Database Modeling

##*Test*

##*Deployment*

##*Improvements*