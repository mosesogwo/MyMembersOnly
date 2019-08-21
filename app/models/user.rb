class User < ApplicationRecord
  before_create :remember_token

  has_secure_password
  has_many :posts


  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  def create_remember_digest
    self.remember_digest = User.digest(User.new_token)
  end

end
