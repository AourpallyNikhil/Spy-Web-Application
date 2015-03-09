class User < ActiveRecord::Base
  #attr_accessor :username,:password,:password_confirm
  VALID_REGEX = /\A[.,_\"'a-zA-Z0-9 ]*\Z/
  validates :username,presence: true, length: { maximum: 50,minimum: 1 },uniqueness: true,format: { with: VALID_REGEX }
  validates :password,presence: true, length: {minimum: 3 },format: { with: VALID_REGEX }
  validates :password_confirm,  presence: true, length: { minimum: 3 },format: { with:VALID_REGEX }
end
