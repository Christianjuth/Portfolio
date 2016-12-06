# Require helpers
require "./app/helpers/helpers"

class User < ActiveRecord::Base
  include Helpers
  has_many :password_resets

  # -- Validators --

  # Validate username is present, unique, and  
  # only contains letters and numbers
  validates_uniqueness_of :username, :on => :create
  validates :username, 
    presence: true, 
    format: { with: /\A([a-z]|[1-9])+\Z/i,
    message: "use letters and numbers only" }

  # Validate email is present and follow the
  # format person@example.com
  validates_uniqueness_of :email, :on => :create
  validates :email, 
    presence: true, 
    format: { with: /\A\S+@\S+\.\S+\Z/i,
    message: "is not valid" },
    allow_blank: true
  
  validates :phone_number, 
    presence: true, 
    format: { with: /\A[0-9]-\([0-9]{3}\)-[0-9]{3}-[0-9]{4}\Z/i,
    message: "is not valid" },
    allow_blank: true
  
  validate :check_password

  def password=(password)
    @new_password = password
    self.hash_salt = BCrypt::Engine.generate_salt
    self.hashed_password = BCrypt::Engine.hash_secret(password, self.hash_salt)
    self.save
  end

  def password(password)
    self.hashed_password == BCrypt::Engine.hash_secret(password, self.hash_salt)
  end
  
  def check_password
    if @new_password == ""
      self.errors.add(:password, "can't be blank")
      return false
    end
  end
  
  def phone=(number)
    if number == ""
      self.phone_number = number
    elsif self.phone_number != number
      code = SecureRandom.urlsafe_base64(30, true)
      self.phone_number = number
      self.phone_number_verified = false
      self.phone_verification_code = code
      send_text("Verify your phone number http://www.christianjuth.com/phone/verify?id=#{self.id}&code=#{code}", number)
    end
  end


  # -- Functions --
  before_save do |record|
    record.username.downcase!
    record.email.downcase!
  end

  # Use this function to destroy table rows
  # belonging to the user before the user is
  # deleted
  before_destroy do |user|
  end
end