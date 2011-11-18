Devise.setup do |config|
  config.mailer_sender = 'support@seologic.com'
  require 'devise/orm/mongoid'
  config.stretches = Rails.env.test? ? 1 : 10
  config.pepper = '29604413dd86fb047d7ba3943502a556f5a688cc9c80e592707bde9146610de212ad3f84e02c883789e8216a91156281c4739b367ef036e8cf9eb38b495b2418'
end