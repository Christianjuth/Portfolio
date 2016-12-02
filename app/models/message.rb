class Message < ActiveRecord::Base

  # -- Validators --

  validates :name, 
    presence: true

  # Validate email is present and follow the
  # format person@example.com
  validates :email, 
    presence: true, 
    format: { with: /\A\S+@\S+\.\S+\Z/i,
    message: "email is not valid" }
  
  validates :fun_fact, 
    presence: true,
    allow_blank: true
  
  validates :message, 
    presence: true
  
  validates :unread, 
    presence: true,
    allow_blank: true
  
  after_initialize :init
  def init
    self.fun_fact    ||= ""
    self.unread      ||= true
  end
end