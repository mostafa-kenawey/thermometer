ActiveJob::Base.queue_adapter = :sidekiq
Sidekiq.default_worker_options = { retry: 2 }
