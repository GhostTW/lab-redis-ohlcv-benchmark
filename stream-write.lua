local time = 1650967560000
for i=1,1000000 do
    time = time + 60000
    local value = tonumber(tonumber(i) * 10)
    redis.call('XADD', 'ghost:{0}:stream:btc:usdt:1m', time, 'open',value, 'close',(value+1), 'high',(value+2), 'low',(value+3), 'vol',(value+4))
end