class Page < ActiveRecord::Base
  
  # -- Validators --
  validates_uniqueness_of :title
  validates :title, 
    presence: true,
    format: { with: /\A[\S]+\Z/i,
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
  
  
  after_initialize :init
  def init
    self.title       ||= Time.now.to_i
    self.content     ||= ""
    self.publish     ||= false
    self.comments    ||= false
  end
end