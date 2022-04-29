local count = 100
local times = redis.call('LRANGE','ghost:{0}:list:btc:usdt:1m:time', 0, count)
local opens = redis.call('LRANGE','ghost:{0}:list:btc:usdt:1m:open', 0, count)
local closes = redis.call('LRANGE','ghost:{0}:list:btc:usdt:1m:close', 0, count)
local highs = redis.call('LRANGE','ghost:{0}:list:btc:usdt:1m:high', 0, count)
local lows = redis.call('LRANGE','ghost:{0}:list:btc:usdt:1m:low', 0, count)
local vols = redis.call('LRANGE','ghost:{0}:list:btc:usdt:1m:vol', 0, count)

local results = {} for i=1, #times do
    results[i] = times[i]..","..opens[i]..","..closes[i]..","..highs[i]..","..lows[i]..","..vols[i]
end

return results