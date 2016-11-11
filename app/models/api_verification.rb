class ApiVerification < ActiveRecord::Base
  
  # -- Validators --
  validates :name, 
    presence: true, 
    format: { with: /\A([a-z]|[1-9])+\Z/i,
    message: "name contains invalid characters" }

  validates :key, 
    presence: true
  
end