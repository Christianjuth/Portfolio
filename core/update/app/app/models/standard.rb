class Standard < ActiveRecord::Base
  
  # -- Validators --
  validates_uniqueness_of :title, :on => :create
  validates :title, 
    presence: true, 
    allow_blank: true,
    format: { with: /\A([\S]|\s)+\Z/i,
    message: "name contains invalid characters" }

  validates :height, 
    presence: true
  
  validates :width, 
    presence: true
  
  validates :description, 
    presence: true,
    allow_blank: true
  
  validates :screenshot, 
    presence: true,
    allow_blank: true
  
  validates :source, 
    presence: true,
    allow_blank: true
  
  
  after_initialize :init
  def init
    self.title       ||= Time.now.to_i
    self.height      ||= 100
    self.width       ||= 100
    self.description ||= ""
    self.screenshot  ||= ""
    self.source      ||= ""
  end
end