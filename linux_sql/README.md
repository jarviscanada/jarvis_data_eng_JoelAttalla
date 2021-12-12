#Linux Cluster Monitoring Agent
****
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
****
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
****
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
****
###Architecture 
Shown through the diagram below, you can see a Linux cluster consisting of three Linux nodes defined
within the virtual machine interphase, consisting of bash script that is executed to collect and process
hardware info and usage. This data is then transmitted through an internal switch to the primary linux node 
consisting of a provisioned Postgres database. Data collected from the *host_info.sh* script will attain the
server host hardware specifications, and store them in the host_info table in the database once, whereas the 
*host_usage.sh* script will attain the server host usage data, and store them in the host_usage table on a 
minute by minute basis.

![Linux_SQL_Architecture](assets/Linux_SQL_Architecture.jpeg)
****
###Scripts 
Below we will discuss each provisioned script each created to execute specific tasks that are essential in 
collecting the data we are seeking to analyze and store.

####psql_docker.sh

- Description <br />
This script will provide the ability to create a PSQL container, as well as start and stop
the created container. The script must pass through implemented parameters prior to creating 
the container, to ensure only one container is created.

- Usage <br />
The script below will create the docker container which consists of the Postgres database we will be utilizing throughout the project if executed. 
The *db_username* section will be the username selected for the database, and the *db_password* section will be the password selected for the database 
prior to creation.
```
./scripts/psql_docker.sh create [db_username] [db_password] ./scripts/psql_docker.sh create "postgres" "password"
```
The script below will start the container when executed.
```
./scripts/psql_docker.sh start
```
The scripts below will stop the container when executed.
```
./scripts/psql_docker.sh stop
```

####host_info.sh

- Description <br />
This scripts will provide the ability to extract hardware specification for the particular server using various of Linux
usage data commands, and transfer the extracted data to the Postgres database, and store the data in the host_info table.
This will be the first shell script processed in order to initialize the provisioned database for the remaining shells that
will be executed next. The particular data which will be extracted throughout this process will be defined throughout the Database
Modeling section.
- Usage <br />
The script below will gather the extracted hardware specifications, process the data and store the data in the assigned table 
in the database. The *psql_host* section consists of the host name. The *psql_port* section consists of the port number for the server
instance. The *db_name* section consists of the name of the database. The *psql_user* section consists of the instance username selected.
The *psql_password consists of the instance password selected.
```
./scripts/host_info.sh psql_host psql_port db_name psql_user psql_password
./scripts/host_info.sh "localhost" 5432 "host_agent" "postgres" "password"
```

####host_usage.sh <br />

- Description <br />
This script will provide the ability to extract usage information, process the data, and store the data in the assigned table in the database.
In comparison to the *host_info.sh* script, the *host_usage.sh* script will execute, extract immediate data, and store the data on a minute to
minute basis. Whereas the *host_info.sh* script will execute once and store the hardware specification data collected once. The particular data 
which will be extracted throughout this process will be defined throughout the Database
Modeling section.
- Usage <br />
The script below will gather the extracted usage information, process the data, and store the data in the assigned table in the 
database. The *psql_host* section consists of the host name. The *psql_port* section consists of the port number for the
server instance. The *db_name* section consists of the name of the database. The *psql_user* section consists of the instance username selected.
The *psql_password consists of the instance password selected.
```
./scripts/host_usage.sh psql_host psql_port db_name psql_user psql_password
./scripts/host_usage.sh "localhost" 5432 "host_agent" "postgres" "password"
```
####crontab <br />

- Description <br />
This script will provide the ability to execute the *host_usage.sh* scripts on a minute by minute basis. Following the
configuration of the crontab, the script will begin to extract *host_usage.sh* data every minute, collect the data, and
update the assigned table in the database regularly. 
- Usage <br />
The script below will configure the crontab script to ensure the *host_usage.sh* is processed minute by minute.
```
* * * * * bash /home/centos/dev/jarvis_data_eng_JoelAttalla/linux_sql/scripts/host_usage.sh localhost 5432 host_agent postgres password &> /tmp/host_usage.log
```
####queries.sql <br />

- Description <br />
This script consists of SQL queries which will provide the ability to group hosts pertaining to their CPU numbers, and sort their memory sizes in descending order.
The script also will then execute the next query which will display the average memory used over a five minute timespan.
Lastly, the script will execute the next query which will detect host failure. These queries will provide an analysis on the monitoring data, in order to manage clusters
in a more effective manner moving forward.
- Usage <br />
The script below will execute the SQL queries.
```
psql -h localhost -U postgres -d host_agent -f queries.sql
```
****
###Database Modeling
****
##*Test*
****
##*Deployment*
****
##*Improvements*