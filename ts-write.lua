local isKeyExists = redis.call('exists', 'ghost:ts:btc:usdt:1m:open')
if isKeyExists == 0 then
    redis.call('TS.CREATE', 'ghost:ts:btc:usdt:1m:open', 'ENCODING', 'UNCOMPRESSED','CHUNK_SIZE', 64, 'LABELS', 'type', 'ts-btc-usdt-1m')
    redis.call('TS.CREATE', 'ghost:ts:btc:usdt:1m:close', 'ENCODING', 'UNCOMPRESSED','CHUNK_SIZE', 64, 'LABELS', 'type', 'ts-btc-usdt-1m')
    redis.call('TS.CREATE', 'ghost:ts:btc:usdt:1m:high', 'ENCODING', 'UNCOMPRESSED','CHUNK_SIZE', 64, 'LABELS', 'type', 'ts-btc-usdt-1m')
    redis.call('TS.CREATE', 'ghost:ts:btc:usdt:1m:low', 'ENCODING', 'UNCOMPRESSED','CHUNK_SIZE', 64, 'LABELS', 'type', 'ts-btc-usdt-1m')
    redis.call('TS.CREATE', 'ghost:ts:btc:usdt:1m:vol', 'ENCODING', 'UNCOMPRESSED','CHUNK_SIZE', 64, 'LABELS', 'type', 'ts-btc-usdt-1m')
end

local keyInfo = redis.call('TS.INFO', 'ghost:ts:btc:usdt:1m:open')
if keyInfo[2] == 0 then
    local time = 1650967560000--tonumber(ARGV[1])
    for i=1,1000000 do
        time = time + 60000
        local value = i * 10
        redis.call('TS.MADD', 'ghost:ts:btc:usdt:1m:open', time, value,
                   'ghost:ts:btc:usdt:1m:close', time, value + 1,
                   'ghost:ts:btc:usdt:1m:high', time, value + 2,
                   'ghost:ts:btc:usdt:1m:low', time, value + 3,
                   'ghost:ts:btc:usdt:1m:vol', time, value + 4)
    end
end

return keyInfo[2]