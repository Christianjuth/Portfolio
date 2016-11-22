class User < ActiveRecord::Base

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
    message: "email is not valid" }


  def password=(password)
    self.hash_salt = BCrypt::Engine.generate_salt
    self.hashed_password = BCrypt::Engine.hash_secret(password, self.hash_salt)
    self.save
  end

  def password(password)
    self.hashed_password == BCrypt::Engine.hash_secret(password, self.hash_salt)
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