require "aws-sdk-apigateway"
require "aws-sdk-cloudformation"
require "aws-sdk-cloudwatchlogs"
require "aws-sdk-dynamodb"
require "aws-sdk-lambda"
require "aws-sdk-s3"
require "aws-sdk-sts"
# Not used in Jets internally but convenient for shared resources
require "aws-sdk-sns"
require "aws-sdk-sqs"

require "aws_mfa_secure/ext/aws" # add MFA support

module Jets::AwsServices
  include GlobalMemoist
  include StackStatus

  def apigateway
    Aws::APIGateway::Client.new(common_aws_options)
  end
  global_memoize :apigateway

  def cfn
    Aws::CloudFormation::Client.new(common_aws_options)
  end
  global_memoize :cfn

  def dynamodb
    Aws::DynamoDB::Client.new(common_aws_options)
  end
  global_memoize :dynamodb

  def aws_lambda
    Aws::Lambda::Client.new(common_aws_options)
  end
  global_memoize :aws_lambda

  def logs
    Aws::CloudWatchLogs::Client.new(common_aws_options)
  end
  global_memoize :logs

  def s3
    Aws::S3::Client.new(common_aws_options)
  end
  global_memoize :s3

  def s3_resource
    Aws::S3::Resource.new(common_aws_options)
  end
  global_memoize :s3_resource

  def sns
    Aws::SNS::Client.new(common_aws_options)
  end
  global_memoize :sns

  def sqs
    Aws::SQS::Client.new(common_aws_options)
  end
  global_memoize :sqs

  def sts
    Aws::STS::Client.new(common_aws_options)
  end
  global_memoize :sts

  private
  def common_aws_options
    opts = {}
    opts = opts.merge(retry_limit: ENV['AWS_RETRY_LIMIT'].to_i) if ENV['AWS_RETRY_LIMIT'].present?
    opts = opts.merge(retry_max_delay: ENV['AWS_RETRY_MAX_DELAY'].to_i) if ENV['AWS_RETRY_MAX_DELAY'].present?
    opts = opts.merge(retry_limit: ENV['AWS_HTTP_READ_TIMEOUT'].to_i) if ENV['AWS_HTTP_READ_TIMEOUT'].present?

    opts
  end
end
