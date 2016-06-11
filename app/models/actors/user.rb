class User < ActiveRecord::Base

  belongs_to :team
  has_many :survey_obligations

  before_create :generate_access_token
  after_create :create_surveys

  def generate_access_token
    self.token = Faker::Hipster.word
  end

  def create_surveys
  	SurveyDefinition.all.each do |survey|
  	end
  end

end