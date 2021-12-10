CREATE TABLE IF NOT EXISTS PUBLIC.host_info

(
     id               SERIAL NOT NULL, 
     hostname         VARCHAR NOT NULL, 
     cpu_number       INT NOT NULL,
     cpu_architecture VARCHAR NOT NULL,
     cpu_model        VARCHAR NOT NULL,
     cpu_mhz          REAL NOT NULL,
     L2_cache         INT NOT NULL,
     total_mem        INT NOT NULL,
     timestamp        TIMESTAMP NOT NULL,
PRIMARY KEY(id),
UNIQUE(hostname)
);

CREATE TABLE IF NOT EXISTS PUBLIC.host_usage

( 
     "timestamp"      TIMESTAMP NOT NULL,
     host_id          INT NOT NULL,
     memory_free      INT NOT NULL,
     cpu_idle         INT NOT NULL,
     cpu_kernel       INT NOT NULL,
     disk_io          INT NOT NULL,
     disk_available   INT NOT NULL, 
FOREIGN KEY(host_id) REFERENCES host_info(id)
);
