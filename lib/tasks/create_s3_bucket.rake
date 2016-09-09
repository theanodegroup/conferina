require 'rubygems'
require 'aws-sdk'

desc "Create S3 bucket"
task create_s3_bucket: :environment do
  s3 = Aws::S3::Client.new(region: ENV['AWS_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']))
  resp = s3.list_buckets
  resp.buckets.map(&:name)
  # https://913134324996.signin.aws.amazon.com/console
  # iam = Aws::IAM::Client.new(
  #   region: ENV['AWS_REGION'],
  #   access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  #   secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  # )
  # resp = iam.get_account_summary()
  # puts resp
end

