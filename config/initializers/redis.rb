# Connection to the redis database
Redis.current = Redis.new(url:  ENV['REDIS_PROVIDER_URL'],
  port: ENV['REDIS_PROVIDER_PORT'],
  db:   ENV['REDIS_PROVIDER_DB'])