class CompanyHeading
  include Mongoid::Document
  include Mongoid::Timestamps

  index :pid
end