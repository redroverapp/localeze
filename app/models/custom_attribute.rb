class CustomAttribute
  include Mongoid::Document
  include Mongoid::Timestamps

  index :pid
end