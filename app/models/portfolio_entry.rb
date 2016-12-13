class PortfolioEntry < ActiveRecord::Base
  
  # -- Validators --
  validates :title, 
    presence: true
  
  validates :font, 
    presence: true, 
    format: { with: /\A([A-Za-z0-9]|-)+\Z/i,
    message: "invalid font" }
  
  validates :color, 
    presence: true, 
    format: { with: /\A#([A-Za-z0-9]){6}\Z/i,
    message: "invalid six digit hex color" }
  
  validates :date, 
    presence: true
  
  validates :website, 
    presence: true, 
    format: { with: /\Ahttps?:\/\/(www\.|)([A-Za-z1-9]+)(\.[\S]+)\Z/i,
    message: "invalid url" },
    allow_blank: true

  validates :github, 
    presence: true, 
    format: { with: /\Ahttps?:\/\/(www\.|)(github)(\.[\S]+)\Z/i,
    message: "invalid github url" },
    allow_blank: true
  
  validates :publish, 
    presence: true,
    allow_blank: true
  
  
  after_initialize :init
  def init
    self.title       ||= "Untilted"
    self.font        ||= "knewave"
    self.blurb       ||= "This is a super awesome project"
    self.description ||= "The quick brown fox jumps over the lazy dog."
    self.color       ||= "#000000"
    self.date        ||= Date.parse(Time.now.to_s)
    self.website     ||= ""
    self.github      ||= ""
    self.publish     ||= false
  end
end