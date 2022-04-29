local isKeyExists = redis.call('exists', 'ghost:{0}:list:latest:ts')
if isKeyExists == 0 then
    local time = 1650967560000
    for i=1,1000000 do
        time = time + 60000
        local v1 = tonumber(tonumber(i) * 1000)
        local v2 = tonumber(tonumber(i+1) * 1000)
        local v3 = tonumber(tonumber(i+2) * 1000)
        local v4 = tonumber(tonumber(i+3) * 1000)
        local v5 = tonumber(tonumber(i+4) * 1000)
        redis.call('LPUSH', 'ghost:{0}:list:btc:usdt:1m:time', time)
        redis.call('LPUSH', 'ghost:{0}:list:btc:usdt:1m:open', v1)
        redis.call('LPUSH', 'ghost:{0}:list:btc:usdt:1m:close', v2)
        redis.call('LPUSH', 'ghost:{0}:list:btc:usdt:1m:high', v3)
        redis.call('LPUSH', 'ghost:{0}:list:btc:usdt:1m:low', v4)
        redis.call('LPUSH', 'ghost:{0}:list:btc:usdt:1m:vol', v5)
    end
    redis.call('SET', 'ghost:{0}:list:latest:ts', time)
end