class User < ApplicationRecord
  before_create :remember

  has_secure_password


  def User.new_token
    Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s)
  end

  def remember
    self.remember_token = User.new_token
  end
end
