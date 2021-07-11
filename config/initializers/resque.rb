# LOG
Resque.logger.level = Logger::DEBUG
Resque.logger = Logger.new(Rails.root.join('log', "#{Rails.env}_resque.log"))

# RESQUE
if Rails.env.production?
  uri = URI.parse ENV["REDISCLOUD_URL"]
  Resque.redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)
else
  Resque.redis = Redis.new(url:  ENV['REDIS_URL'],
    port: ENV['REDIS_PORT'],
    db:   ENV['REDIS_DB'])
end