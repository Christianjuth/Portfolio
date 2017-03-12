class PasswordReset < ActiveRecord::Base
  belongs_to :user
  
  def active?
    return self.created_at > 20.minutes.ago
  end
end