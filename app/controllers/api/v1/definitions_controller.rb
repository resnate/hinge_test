class Api::V1::DefinitionsController < Api::V1::ApiController
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
	end

	def submittable_now
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