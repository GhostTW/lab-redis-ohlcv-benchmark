redis.call('SET', 'ghost:{{0}}:lua', 1)
redis.call('GET', 'ghost:{0}:lua')