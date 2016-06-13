class Api::V1::DefinitionsController < Api::V1::ApiController
	@surveys = SurveyObligation.where(user_id: @current_user.id).all
	def show
		if SurveyDefinition.where(id: params[:identifier]).count > 0
			@type = "id"
			@id = params[:identifier]
		elsif SurveyDefinition.where(id: params[:identifier]).count > 0
			@type = "name"
			@name = params[:identifier]
		else
			render text: '{"error": "not_found"}'
		end
	end

	def due_this_week
		@results = []
		@surveys.each do |survey|
			if survey.due_at.beginning_of_week == DateTime.now.beginning_of_week
				@results.push(SurveyDefinition.find(survey.survey_definition_id)
			end
		end
		paginate json: @results, per_page: 5
	end

	def submittable_now
		@results = []
		@surveys.each do |survey|
			if survey.valid_submission?
				@results.push(SurveyDefinition.find(survey.survey_definition_id))
			end
		end
		paginate json: @results, per_page: 5
	end

	def due
		@results = []
		SurveyDefinition.all.each do |survey|
			if survey.week_indices.include?(params[:week_index])
				@results.push(survey)
			end
		end
		paginate json: @results, per_page: 5
	end
end