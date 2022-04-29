# Redis Stack

## Release Date
June 27, 2019 general availability (GA) of RedisTimeSeries v1.0
[ref](https://redis.com/blog/redistimeseries-ga-making-4th-dimension-truly-immersive/)

## Modules
Queryable JSON documents
Full-text search
Time series data (ingestion & querying)
Graph data models with the Cypher query language
Probabilistic data structures

## Supported Version
Redis Stack is now generally available for Redis 6.2, and we also have a release candidate for Redis 7.0.
[ref](https://redis.com/blog/introducing-redis-stack/)

## About the Redis Source Available License (RSAL)
RSAL is a software license created by Redis Ltd. (formerly “Redis Labs”) for certain Redis Modules running on top of open source Redis. RSAL grants equivalent rights to permissive open source licenses for the vast majority of users. With RSAL, developers can use the software, modify the source code, integrate it with an application, and use, distribute or sell the application. The only restriction is that the application cannot be a database, a caching engine, a stream processing engine, a search engine, an indexing engine or an ML/DL/AI serving engine.
[ref](https://redis.com/legal/licenses/)

## Migrate
easily migrate your data using the Redis replication mechanism or by loading your RDB or AOF file
unsure

## RedisTimeSeries
[redis.io](https://redis.io/docs/stack/timeseries/)
[github](https://github.com/RedisTimeSeries)

### Features
* High volume inserts, low latency reads
* Query by start time and end-time
* Aggregated queries (min, max, avg, sum, range, count, first, last, STD.P, STD.S, Var.P, Var.S) for any time bucket
* Configurable maximum retention period
* Downsampling / compaction for automatically updated aggregated timeseries
* Secondary indexing for time series entries. Each time series has labels (field value pairs) which will allows to query by labels

### Usages

* see each timeseries as a bucket.
* bucket labels for filtering.
* value is the numeric data value
* query
    Filtering by label
    Filtering by value
    Filtering by timestamp
    Aggregation

### Benchmark

#### Sorted Set and TimeSeries
https://redis.com/blog/redistimeseries-ga-making-4th-dimension-truly-immersive/

https://redis.com/blog/redistimeseries-version-1-2-benchmarks/


### POC Lab
docker run -d --name redis-stack-server -v `pwd`/data/:/data -p 6379:6379 redis/redis-stack-server:latest

#### Create TS
TS.CREATE btc:usdt:1m:open LABELS type btc-usdt-1m
TS.CREATE btc:usdt:1m:close LABELS type btc-usdt-1m
TS.CREATE btc:usdt:1m:high LABELS type btc-usdt-1m
TS.CREATE btc:usdt:1m:low LABELS type btc-usdt-1m

TS.CREATE btc:usdt:1h:open LABELS type btc-usdt-1h
TS.CREATE btc:usdt:1h:close LABELS type btc-usdt-1h
TS.CREATE btc:usdt:1h:high LABELS type btc-usdt-1h
TS.CREATE btc:usdt:1h:low LABELS type btc-usdt-1h

#### ADD points

TS.MADD btc:usdt:1m:open 1650956160000 40001 btc:usdt:1m:close 1650956160000 40002 btc:usdt:1m:high 1650956160000 40004 btc:usdt:1m:low 1650956160000 40000
TS.MADD btc:usdt:1m:open 1650956220000 40011 btc:usdt:1m:close 1650956220000 40012 btc:usdt:1m:high 1650956220000 40014 btc:usdt:1m:low 1650956220000 40010
TS.MADD btc:usdt:1m:open 1650956280000 40021 btc:usdt:1m:close 1650956280000 40022 btc:usdt:1m:high 1650956280000 40024 btc:usdt:1m:low 1650956280000 40020
TS.MADD btc:usdt:1m:open 1650956340000 40031 btc:usdt:1m:close 1650956340000 40032 btc:usdt:1m:high 1650956340000 40034 btc:usdt:1m:low 1650956340000 40030

TS.MADD btc:usdt:1h:open 1650952800000 40001 btc:usdt:1h:close 1650952800000 40002 btc:usdt:1h:high 1650952800000 40004 btc:usdt:1h:low 1650952800000 40000
TS.MADD btc:usdt:1h:open 1650956400000 40011 btc:usdt:1h:close 1650956400000 40012 btc:usdt:1h:high 1650956400000 40014 btc:usdt:1h:low 1650956400000 40010
TS.MADD btc:usdt:1h:open 1650960000000 40021 btc:usdt:1h:close 1650960000000 40022 btc:usdt:1h:high 1650960000000 40024 btc:usdt:1h:low 1650960000000 40020
TS.MADD btc:usdt:1h:open 1650963600000 40031 btc:usdt:1h:close 1650963600000 40032 btc:usdt:1h:high 1650963600000 40034 btc:usdt:1h:low 1650963600000 40030

#### Query

TS.MRANGE 1650956220000 1650956280000 FILTER type=btc-usdt-1m

```
127.0.0.1:6379> TS.MRANGE 1650956220000 1650956280000 FILTER type=btc-usdt-1m
1) 1) "btc:usdt:1m:close"
   2) (empty array)
   3) 1) 1) (integer) 1650956220000
         2) 40012
      2) 1) (integer) 1650956280000
         2) 40022
2) 1) "btc:usdt:1m:high"
   2) (empty array)
   3) 1) 1) (integer) 1650956220000
         2) 40014
      2) 1) (integer) 1650956280000
         2) 40024
3) 1) "btc:usdt:1m:low"
   2) (empty array)
   3) 1) 1) (integer) 1650956220000
         2) 40010
      2) 1) (integer) 1650956280000
         2) 40020
4) 1) "btc:usdt:1m:open"
   2) (empty array)
   3) 1) 1) (integer) 1650956220000
         2) 40011
      2) 1) (integer) 1650956280000
         2) 40021
```

```
127.0.0.1:6379> TS.MREVRANGE - 1650956280000 COUNT 1 FILTER type=btc-usdt-1m
1) 1) "btc:usdt:1m:close"
   2) (empty array)
   3) 1) 1) (integer) 1650956280000
         2) 40022
2) 1) "btc:usdt:1m:high"
   2) (empty array)
   3) 1) 1) (integer) 1650956280000
         2) 40024
3) 1) "btc:usdt:1m:low"
   2) (empty array)
   3) 1) 1) (integer) 1650956280000
         2) 40020
4) 1) "btc:usdt:1m:open"
   2) (empty array)
   3) 1) 1) (integer) 1650956280000
         2) 40021
```


#### Downsampling

TS.CREATE btc:usdt:1m:open LABELS type btc-usdt-1m
TS.CREATE btc:usdt:1m:close LABELS type btc-usdt-1m
TS.CREATE btc:usdt:1m:high LABELS type btc-usdt-1m
TS.CREATE btc:usdt:1m:low LABELS type btc-usdt-1m

TS.CREATE btc:usdt:5m:open:compacted LABELS type btc-usdt-5m
TS.CREATE btc:usdt:5m:close:compacted LABELS type btc-usdt-5m
TS.CREATE btc:usdt:5m:high:compacted LABELS type btc-usdt-5m
TS.CREATE btc:usdt:5m:low:compacted LABELS type btc-usdt-5m

TS.CREATERULE btc:usdt:1m:open btc:usdt:5m:open:compacted AGGREGATION FIRST 300000
TS.CREATERULE btc:usdt:1m:close btc:usdt:5m:close:compacted AGGREGATION LAST 300000
TS.CREATERULE btc:usdt:1m:high btc:usdt:5m:high:compacted AGGREGATION MAX 300000
TS.CREATERULE btc:usdt:1m:low btc:usdt:5m:low:compacted AGGREGATION MIN 300000

TS.MADD btc:usdt:1m:open 1650967200000 40001 btc:usdt:1m:close 1650967200000 40002 btc:usdt:1m:high 1650967200000 40004 btc:usdt:1m:low 1650967200000 40000
TS.MADD btc:usdt:1m:open 1650967260000 40011 btc:usdt:1m:close 1650967260000 40012 btc:usdt:1m:high 1650967260000 40014 btc:usdt:1m:low 1650967260000 40010
TS.MADD btc:usdt:1m:open 1650967320000 40021 btc:usdt:1m:close 1650967320000 40022 btc:usdt:1m:high 1650967320000 40024 btc:usdt:1m:low 1650967320000 40020
TS.MADD btc:usdt:1m:open 1650967380000 40031 btc:usdt:1m:close 1650967380000 40032 btc:usdt:1m:high 1650967380000 40034 btc:usdt:1m:low 1650967380000 40030
TS.MADD btc:usdt:1m:open 1650967440000 40031 btc:usdt:1m:close 1650967440000 40032 btc:usdt:1m:high 1650967440000 40034 btc:usdt:1m:low 1650967440000 40030
TS.MADD btc:usdt:1m:open 1650967500000 40031 btc:usdt:1m:close 1650967500000 40032 btc:usdt:1m:high 1650967500000 40034 btc:usdt:1m:low 1650967500000 40030
TS.MADD btc:usdt:1m:open 1650967560000 40061 btc:usdt:1m:close 1650967560000 40062 btc:usdt:1m:high 1650967560000 40064 btc:usdt:1m:low 1650967560000 40060

* Downsampling only occurs while end of period.

ex:
duration: 300000
10:15:00 data generated at 10:15:00 AM.

#### DELETE TS

DEL btc:usdt:1m:open
DEL btc:usdt:1m:close
DEL btc:usdt:1m:high
DEL btc:usdt:1m:low 
DEL btc:usdt:1h:open
DEL btc:usdt:1h:close
DEL btc:usdt:1h:high
DEL btc:usdt:1h:low 


## SortedSet

### Lab

#### Add points (open, close, high, low)
ZADD ss:btc:usdt:1m 1650956160000 "40001,40002,40004,40000"
ZADD ss:btc:usdt:1m 1650956220000 "40011,40012,40014,40010"
ZADD ss:btc:usdt:1m 1650956280000 "40021,40022,40024,40020"
ZADD ss:btc:usdt:1m 1650956340000 "40031,40032,40034,40030"

ZADD ss:btc:usdt:1h 1650952800000 "40001,40002,40004,40000"
ZADD ss:btc:usdt:1h 1650956400000 "40011,40012,40014,40010"
ZADD ss:btc:usdt:1h 1650960000000 "40021,40022,40024,40020"
ZADD ss:btc:usdt:1h 1650963600000 "40031,40032,40034,40030"

#### Query

```
127.0.0.1:6379> ZRANGE ss:btc:usdt:1m +inf -inf BYSCORE REV
1) "o:40031,c:40032,h:40034,l:40030"
2) "o:40021,c:40022,h:40024,l:40020"
3) "o:40011,c:40012,h:40014,l:40010"
4) "o:40001,c:40002,h:40004,l:40000"
127.0.0.1:6379> ZRANGE ss:btc:usdt:1m 1650956280000 -inf BYSCORE REV
1) "o:40021,c:40022,h:40024,l:40020"
2) "o:40011,c:40012,h:40014,l:40010"
3) "o:40001,c:40002,h:40004,l:40000"
127.0.0.1:6379> ZRANGE ss:btc:usdt:1m 1650956280000 -inf BYSCORE REV LIMIT 0 1
1) "o:40021,c:40022,h:40024,l:40020"
```

## Benchmark Lab

### Scenario

query criteria: coin, paycoin, time range, count
write: always update last 2 points

10,000 points

### Stack - TimeSeries

1. get 1000 points by criteria

`redis-cli -x script load < ts-query-latest-1000.lua`
`redis-benchmark -n 1000 EVALSHA 6f69cf1f88b4f7432ef119b4cdba507b91ccf6eb 0`

local
points 10000000
query 1000 point
COMMPRESSED
Summary:
  throughput summary: 9.18 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
     2972.399  1143.808  3000.319  3000.319  3000.319  3000.319
Used Memory Peak: 31.29M

local
points 10000000
query 100 point
COMMPRESSED
Summary:
  throughput summary: 93.86 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
      522.266   111.232   492.543   692.223   864.255   999.935

local
points 10000000
query 100 point
UNCOMMPRESSED
Summary:
  throughput summary: 96.67 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
      507.368    87.488   496.383   600.063   865.791   980.991

local
points 10000000
query 100 point
CHUNK_SIZE 64 (default:4096)
Summary:
  throughput summary: 93.78 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
      525.131    38.464   503.295   678.399   880.639   994.815

local
points 10000000
query 100 point
CHUNK_SIZE 64 (default:4096)
UNCOMMPRESSED
Summary:
  throughput summary: 70.43 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
      690.494    13.504   567.807  1130.495  1164.287  1842.175

local
points 10000000
query 1 point
COMMPRESSED
Summary:
  throughput summary: 1425.11 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
       34.853    13.592    36.191    48.607    56.863    88.383

### LIST

* store latest ts of point in a key

1. get latest ts
2. get 1000 points by criteria

`redis-cli -x script load < list-query-latest-1000.lua`
`redis-benchmark -n 1000 EVALSHA 8539b22d3b18b6c7792bafd07397c49c29efb2cf 0 1710967826000 60000`

local
points 10000000
query 1000 point
Summary:
  throughput summary: 360.10 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
      123.966    26.640   123.007   169.215   192.127   197.375
Used Memory Peak: 53.61M

local
points 10000000
query 100 point
Summary:
  throughput summary: 3094.49 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
       32.193     7.344    32.111    41.791    47.487    84.479

local
points 10000000
query 100 data(2 points in a data)
Summary:
  throughput summary: 2264.70 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
       44.083     6.072    43.391    67.391    77.631   123.967

local
points 10000000
query 100 data(5 points in a data)
Summary:
  throughput summary: 995.22 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
       84.035     6.136    85.183   126.079   147.583   220.927

local
points 10000000
query 100 data(write to different field list and combine in query request)
Summary:
  throughput summary: 845.73 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
      118.116    22.384   118.207   127.871   138.623   338.175

local
points 10000000
query 10 point
Summary:
  throughput summary: 11054.61 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
        8.808     2.176     8.351    12.983    16.335    39.903

local
points 10000000
query 1 point
Summary:
  throughput summary: 13468.92 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
        7.220     1.288     6.559    11.663    14.919    44.095

local
points 10000
query 100 point
Summary:
  throughput summary: 2770.08 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
       17.731    11.672    15.887    31.199    55.455    56.895

DEV
points 10000000
query 1000 point
Summary:
  throughput summary: 531.07 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
       58.550     9.584    54.783   102.463   111.743   290.047

### SortedList

1. get 1000 points by criteria

`redis-cli -x script load < ss-query-latest-1000.lua`
`redis-benchmark -n 1000 EVALSHA dd13c359ed15a18d60e4083d61c726b566c943f1 0`

local
points 10000
query 1000 point
Summary:
  throughput summary: 177.87 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
      274.999    73.920   273.407   296.703   304.383   424.959

Used Memory Peak: 120.57M

local
points 10000
query 100 point
Summary:
  throughput summary: 2817.06 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
       35.333    11.384    35.423    42.079    44.863    77.631

### Baseline

GET
   DEV 22000 rps
   local 20000 rps

➜  redis-timeseries redis-cli --intrinsic-latency 100
Max latency so far: 1 microseconds.
Max latency so far: 8 microseconds.
Max latency so far: 10 microseconds.
Max latency so far: 17 microseconds.
Max latency so far: 95 microseconds.
Max latency so far: 121 microseconds.
Max latency so far: 295 microseconds.
Max latency so far: 5574 microseconds.
Max latency so far: 10550 microseconds.
4231122988 total runs (avg latency: 0.0236 microseconds / 23.63 nanoseconds per run).
Worst run took 446383x longer than the average latency.