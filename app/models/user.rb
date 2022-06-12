class User < ApplicationRecord
  has_secure_password

  ## Association
  has_many :sessions
end
