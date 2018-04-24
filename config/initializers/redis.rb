# initialize a redis server
$redis = Redis::Namespace.new("WoS", :redis => Redis.new)
