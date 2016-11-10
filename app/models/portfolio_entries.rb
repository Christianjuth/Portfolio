class PortfolioEntry < ActiveRecord::Base
  after_initialize :init
  def init
    self.title       ||= "Untilted"
    self.font        ||= "knewave"
    self.blurb       ||= "This is a super awesome project"
    self.description ||= "The quick brown fox jumps over the lazy dog."
    self.color       ||= "#000"
  end
end