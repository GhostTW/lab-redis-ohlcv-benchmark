local isKeyExists = redis.call('exists', 'ghost:{0}:list:latest:ts')
if isKeyExists == 0 then
    local time = 1650967560000
    for i=1,1000000 do
        time = time + 60000
        local value = tonumber(tonumber(i) * 10)
        redis.call('LPUSH', 'ghost:{0}:list:btc:usdt:1m', time..","..value..","..(value+1)..","..(value+2)..","..(value+3)..","..(value+4))
    end
    redis.call('SET', 'ghost:{0}:list:latest:ts', time)
end