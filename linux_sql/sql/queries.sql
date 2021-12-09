SELECT cpu_number,id,total_mem
FROM host_info
GROUP BY cpu_number, id
ORDER BY cpu_number, total_mem DESC;

SELECT data_trunc('hour', timestamp) + date_part('minute', timestamp):: int / 5 * interval '5 min'
FROM host_usage;

CREATE FUNCTION round5(ts timestamp) RETURNS timestamp AS
$$
BEGIN
    RETURN date_trunc('hour', ts) + date_part('minute', ts):: int / 5 * interval '5 min';
END;
$$
   LANGUAGE PLPGSQL;

SELECT host_id, timestamp, round5(timestamp)
FROM host_usage;

SELECT host_id, hostname, ROUND((AVG(host_info.total_usage.memory_free * 1000)/host_info.total_mem)*100) AS avg_used_percentage,
round5(host_usage.timestamp)
FROM host_usage
JOIN host_info
ON host_info.id = host_usage.host_id
GROUP BY host_usage.timestamp, host_id, hostname, total_mem;

SELECT DISTINCT host_id, round5(host_usage.timestamp) AS time_stamp,
COUNT (*) AS num_data_points
FROM host_usage
GROUP BY time_stamp, host_id
HAVING COUNT(*) <= 3;
