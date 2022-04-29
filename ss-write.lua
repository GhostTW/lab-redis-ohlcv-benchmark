local time = 1650967560000--tonumber(ARGV[1])
for i=1,1000000 do
    time = time + 60000
    local v1 = i * 10
    local v2 = v1 + 1
    local v3 = v2 + 1
    local v4 = v3 + 1
    local v5 = v4 + 1
    redis.call('ZADD', 'ghost:{0}:ss:btc:usdt:1m', time, v1..","..v2..","..v3..","..v4..","..v5)
end