Sidekiq.configure_server do |config|
  config.redis = { url:  ENV['REDIS_PROVIDER_URL'],
    port: ENV['REDIS_PROVIDER_PORT'],
    db:   ENV['REDIS_PROVIDER_DB']
  }
end

Sidekiq.configure_client do |config|
  config.redis = { url:  ENV['REDIS_PROVIDER_URL'],
    port: ENV['REDIS_PROVIDER_PORT'],
    db:   ENV['REDIS_PROVIDER_DB']
  }
end