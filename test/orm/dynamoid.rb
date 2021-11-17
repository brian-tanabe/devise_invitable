require 'dynamoid'

Dynamoid.configure do |config|
    # To namespace tables created by Dynamoid from other tables you might have.
    # Set to nil to avoid namespacing.
    config.namespace = Rails.env.downcase

    # [Optional]. If provided, it communicates with the DB listening at the endpoint.
    # This is useful for testing with DynamoDB Local
    # http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html
    if Rails.env.development? or Rails.env.test?
        config.endpoint = 'http://localhost:8000'
        config.sync_retry_wait_seconds = 0.50
        config.sync_retry_max_times = 5
    end

    config.backoff = { exponential: { base_backoff: 0.1.seconds, ceiling: 10 } }
end