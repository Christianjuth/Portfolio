class ApiVerification < ActiveRecord::Base
  
  # -- Validators --
  validates_uniqueness_of :name, :on => :create
  validates :name, 
    presence: true, 
    allow_blank: true,
    format: { with: /\A[\S]+\Z/i,
    message: "name contains invalid characters" }

  validates :key, 
    presence: true,
    allow_blank: true
  
  validates :secret, 
    presence: true,
    allow_blank: true
  
  
  after_initialize :init
  def init
    self.name       ||= Time.now.to_i
    self.key        ||= ""
    self.secret     ||= ""
  end
end