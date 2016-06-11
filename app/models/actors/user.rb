class User < ActiveRecord::Base

  belongs_to :team
  has_many :survey_obligations

  before_create :generate_access_token

  def generate_access_token
    self.token = Faker::Hipster.word
  end

end