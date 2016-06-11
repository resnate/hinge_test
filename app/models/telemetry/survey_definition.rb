class SurveyDefinition < ActiveRecord::Base

  has_many :survey_obligations

=begin

1) Survey Definitions serve as general maps for the possible surveys served in the app
2) The format column is an array of field specs; they define the name, whether required or not, and the value type
3) The week indicies is an array of week on which users should be served the survey
4) A week index is relative to the user's team's pathway_starts_at (more on that in the Survey Obligation class file)

=end


end