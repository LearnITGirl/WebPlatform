CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['S3_KEY'],
    aws_secret_access_key: ENV['S3_SECRET'],
    region: 'eu-west-1'
  }

  if Rails.env.test? || Rails.env.development?
    config.storage = :file
    config.root = "#{Rails.root}/public"
    config.asset_host = 'http://localhost:3000'
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"

  config.fog_directory = ENV['S3_BUCKET_NAME']
end 
