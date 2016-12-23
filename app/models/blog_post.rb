class BlogPost < ActiveRecord::Base
  
  # -- Validators --
  validates :title, 
    presence: true,
    format: { with: /\A([\S]|\s)+\Z/i,
    message: "invalid title" }
  
  validates :content, 
    presence: true,
    allow_blank: true
  
  validates :comments, 
    presence: true,
    allow_blank: true
  
  validates :publish, 
    presence: true,
    allow_blank: true
  
  validates :publish_date, 
    presence: true
  
  validates :header_image, 
    presence: true,
    allow_blank: true
  
  
  after_initialize :init
  def init
    self.title        ||= "Untitled"
    self.header_image ||= ""
    self.content      ||= ""
    self.comments     ||= false
    self.publish      ||= false
    self.publish_date ||= Date.parse(Time.now.to_s)
  end
end