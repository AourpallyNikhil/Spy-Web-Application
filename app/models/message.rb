class Message < ActiveRecord::Base
  VALID_REGEX = /\A[.,_\"'a-zA-Z0-9 ]*\Z/
  validates :title,  presence: true,format: { with: VALID_REGEX }
  validates :message,  presence: true,format: { with: VALID_REGEX }
end
