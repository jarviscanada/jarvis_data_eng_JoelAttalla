#Linux Cluster Monitoring Agent
****
##*Introduction* 
The sole purpose of the Linux Cluster Monitoring Agent is to provide users with the capabilities to store and analyze 
system metrics, in order to monitor system performance in an effective manner.
Through having hardware specifications and resource usage data processed and updated (using various bash scripts to obtain
required data from each distinct node and store it into established database found in the main node),
this provides the user with the ability to access this data efficiently in order to address any issues directly. All gathered data 
is stored within a PostgreSQL database, curated to centralize data across numerous of cluster nodes. 

Technologies and softwares used throughout this process include: Google Cloud Platform, Git, VNC Server/Viewer, Linux CentOS 7, 
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
and architecture and identifying the purpose of each file being created throughout the 
file directory. By understanding the purpose of each and every process throughout the 
project, this provided an accurate representation of how the final product should look. 
Following this, we continued to provision a PSQL instance using Docker and installed
the PSQL CLI client tool to ensure were equipped with the necessary tools to start 
the development process. Once this was complete, we began the development process. This started with
writing bash scripts to create containers, collecting and processing system performance data,
storing the collected data in assigned databases, and implementing monitoring programs to
continuously collect resource data usage and hardware specifications across servers. Lastly,
we had incorporated compiled SQL queries to organize data clusters and resolve any issues that
may have arisen throughout the deployment process. 

In this section, we will discuss the architecture design, description
and usage of each shell script, and database modeling.
****
###Architecture 
Shown through the diagram below, you can see a Linux cluster comprising of three Linux nodes defined
within the virtual machine interphase. This consists of bash script that was executed to collect and process
hardware information and usage. This data was then transmitted through an internal switch to the primary linux node 
including a provisioned Postgres database. Data collected from the *host_info.sh* script will attain the
server host hardware specifications and store them in the host_info table in the database only once, whereas the 
*host_usage.sh* script will attain the server host usage data and store them in the host_usage table on a 
minute by minute basis.

![Linux_SQL_Architecture](assets/Linux_SQL_Architecture.jpeg)
****
###Scripts 
Below we will discuss each provisioned script created to execute specific tasks that were essential to collecting the data we are seeking to analyze and store.

####psql_docker.sh

- Description <br />
This script will provide the user with the ability to create a PSQL container, as well as start and stop
the created container. The script must pass through implemented parameters prior to creating 
the container to ensure only one container is created.

- Usage <br />
The script below will create the docker container which consists of the Postgres database we will be using throughout the project if executed. 
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
This scripts will provide the user with the ability to extract hardware specifications for the particular server (using various Linux
usage data commands), transfer the extracted data to the Postgres database, and store the data in the host_info table.
This will be the first shell script processed in order to initialize the provisioned database for the remaining shells that
will be executed next. The particular data which will be extracted throughout this process will be defined throughout the Database
Modeling section.
- Usage <br />
The script below will gather the extracted hardware specifications, process and store the data in the assigned table 
in the database. The *psql_host* section consists of the host name. The *psql_port* section consists of the port number for the server
instance. The *db_name* section consists of the name of the database. The *psql_user* section consists of the instance username selected.
The *psql_password consists of the instance password selected.
```
./scripts/host_info.sh psql_host psql_port db_name psql_user psql_password
./scripts/host_info.sh "localhost" 5432 "host_agent" "postgres" "password"
```

####host_usage.sh <br />

- Description <br />
This script will provide the user with the ability to extract usage information, process and store the data in the assigned table in the database.
In comparison to the *host_info.sh* script, the *host_usage.sh* script will execute, extract immediate data, and store the data on a minute by
minute basis. In contrast, the *host_info.sh* script will execute once and store the hardware specification data collected once. The specific data 
which will be extracted throughout this process will be defined throughout the Database
Modeling section.
- Usage <br />
The script below will gather the extracted usage information, process and store the data in the assigned table in the 
database. The *psql_host* section consists of the host name. The *psql_port* section consists of the port number for the
server instance. The *db_name* section consists of the name of the database. The *psql_user* section consists of the instance username selected.
The *psql_password* consists of the instance password selected.
```
./scripts/host_usage.sh psql_host psql_port db_name psql_user psql_password
./scripts/host_usage.sh "localhost" 5432 "host_agent" "postgres" "password"
```
####crontab <br />

- Description <br />
This script will provide the user with the ability to execute the *host_usage.sh* scripts on a minute by minute basis. Following the
configuration of the crontab, the script will begin to extract *host_usage.sh* data every minute, collect the data, and
update the assigned table in the database regularly. 
- Usage <br />
The script below will configure the crontab script to ensure the *host_usage.sh* is processed minute by minute.
```
* * * * * bash /home/centos/dev/jarvis_data_eng_JoelAttalla/linux_sql/scripts/host_usage.sh localhost 5432 host_agent postgres password &> /tmp/host_usage.log
```
####queries.sql <br />

- Description <br />
This script consists of SQL queries which will provide the user with the ability to group hosts pertaining to their CPU numbers, and sort their memory sizes in descending order.
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
Presented below is a model of the provisioned tables within the host_agent database, consisting of the extracted data collected
from the *host_info.sh* and *host_usage.sh* scripts. The *host_info.sh* script is executed once and stores the hardware specification
data in the variables presented in the host_info table, whereas the variables in the host_usage table are updated every minute, as the 
*host_usage* script will run and update minute by minute.

####host_info Table
Variable | Data Type | Description
-----------|------|-----------
id | `SERIAL` | Primary Key; created automatically when entered into the database. 
hostname | `VARCHAR` | Server name holder.
cpu_number | `INT` | Number of CPUs listed in server.
cpu_architecture | `VARCHAR` | Holds CPU architecture specifications.
cpu_model | `VARCHAR` | CPU model holder.
cpu_mhz | `REAL` | CPU MHz holder.
L2_cache | `INT` | Holds L2 cache amount (KB).
total_mem | `INT` | Holds total amount of memory (KB).
timestamp | `TIMESTAMP` | Timestamp, formatted in UTC timezone.

####host_usage Table
Variable | Data Type | Description
-----------|------|-----------
timestamp | `TIMESTAMP` | Timestamp, formatted in UTC timezone.
host_id | `INT` | Foreign Key; holds ID of the host.
memory_free | `INT` | Displays free memory (MB).
cpu_idle | `INT` | Displays percentage of idle CPU time.
cpu_kernel | ` INT ` | Displays percentage of CPU usage.
disk_io | `INT` | Carries amount of I/O that is being used.
disk_available | `INT` | Confirms amount of available disk space in CPU.
****
##*Test*
Following the completion of all scripts required to process and store the data, we began the
testing phase to ensure the data was being retrieved, processed, and stored properly with no issues.
Each script was executed using their assigned commands to process the data in alliance with the Postgres
database to ensure all scripts were transmitting retrieved data into the database correctly with no issues.
Once all the bash scripts completed their tests, the SQL queries were then executed and tested to ensure the 
queries generated the adequate output (ensuring clusters were able to be managed more effectively).
****
##*Deployment*
Following the testing phase, all provisioned scripts were added, committed, and pushed (deployed)
to the jarvis_data_eng_JoelAttalla/linux_sql directory in the Github repository for review. Once a
review has been completed to ensure functionality, any remaining adjustments required to be made will
be adjusted immediately, in which the project will be deemed complete.
****
##*Improvements*
- Unlike the *host_usage.sh* script, which will continuously update the host_usage table with the immediate usage
data on a minute by minute basis, the *host_info.sh* currently only collects the hardware specification data once. 
This results in any alterations or updates to the hardware specifications to not be updated within the host_info
table in the Postgres database, which leads to inaccurate host specification data being present within the table
  (as the table consists of the original data presented earlier on).
- Enhancing error checking processes in response to errors throughout bash scripts, the Postgres database, and SQL
queries, to provide the ability to resolve these issues efficently and effectively. 
- Completing all error handling, debugging, and proofreading of all scripts and queries prior to
pushing changes to the assigned Github repository, to reduce the number of commits and pushes made throughout
the project. Pushing to the Github repository should be utilized as a final deployment ready for review, rather than multiple
pushes made to alter any errors.
