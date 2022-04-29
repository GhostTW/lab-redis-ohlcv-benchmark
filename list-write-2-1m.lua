local isKeyExists = redis.call('exists', 'ghost:{0}:list:latest:ts')
if isKeyExists == 0 then
    local time = 1650967560000
    for i=1,1000000,2 do
        time = time + 60000
        local value = ''
        for y=0,1 do
            local v1 = tonumber(tonumber(i+y) * 1000)
            local v2 = tonumber(tonumber(i+y+1) * 1000)
            local v3 = tonumber(tonumber(i+y+2) * 1000)
            local v4 = tonumber(tonumber(i+y+3) * 1000)
            local v5 = tonumber(tonumber(i+y+4) * 1000)
            value = value..time..","..v1..","..v2..","..v3..","..v4..","..v5..";"
        end
        redis.call('LPUSH', 'ghost:{0}:list:btc:usdt:1m2', value)
    end
    redis.call('SET', 'ghost:{0}:list:latest:ts', time)
end