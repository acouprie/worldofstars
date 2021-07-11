# Connection to the redis database
if ENV["REDISCLOUD_URL"]
  Redis.current = Redis.new(url: ENV["REDISCLOUD_URL"])
else
  Redis.current = Redis.new(url:  ENV['REDIS_URL'],
    port: ENV['REDIS_PORT'],
    db:   ENV['REDIS_DB'])
end