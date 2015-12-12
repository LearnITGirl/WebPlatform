CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.development?
    config.storage = :file
    config.root = "#{Rails.root}/public"
    config.asset_host = 'http://localhost:3000'
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  else
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_KEY'],
      aws_secret_access_key: ENV['S3_SECRET'],
      region: 'eu-west-1'
    }

    config.storage = :fog
    config.fog_directory = ENV['S3_BUCKET_NAME']
  end
end
