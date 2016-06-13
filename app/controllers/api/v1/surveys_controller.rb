class Api::V1::SurveysController < Api::V1::ApiController

	@surveys = SurveyObligation.where(user_id: @current_user.id).all

	def home
		
	end
	
	def show
		if @surveys.where(id: params[:identifier]).count > 0
			@survey = @surveys.first
			@type = "id"
			@id = params[:identifier]
			render json: @survey, except: [:user_id, :updated_at, :created_at]
		elsif @surveys.where(name: params[:identifier]).count > 0
			@survey = @surveys.first
			@type = "name"
			@name = params[:identifier]
			render json: @survey, except: [:user_id, :updated_at, :created_at]
		else
			render text: '{"error": "not_found"}'
		end
	end

	def due_this_week
		@results = []
		@surveys.each do |survey|
			if survey.due_at.beginning_of_week == DateTime.now.beginning_of_week
				@results.push(survey)
			end
		end
		paginate json: @results, per_page: 5
	end

	def missed
		@results = []
		@surveys.each do |survey|
			if survey.expires_at < DateTime.now && survey.submitted_at.nil?
				@results.push(survey)
			end
		end
		paginate json: @results, per_page: 5
	end

	def submittable_now
		@results = []
		@surveys.each do |survey|
			if survey.valid_submission?
				@results.push(survey)
			end
		end
		paginate json: @results, per_page: 5
	end

	def due
		@results = []
		start = Team.find(@current_user.team_id).program_starts_at
		due = start + (7 * params[:week_index])
		@surveys.where(due_at: due).each do |survey|
			@results.push(survey)
		end
		paginate json: @results, per_page: 5
	end
=begin
1) All responses sent back to the requester in JSON
2) All actions that return lists must support pagination specified in the params (i.e items_per_page=y)
3) Users are identified & authenticated against the "token" column. You can choose whether you expect the value in the params or headers
4) Obviously, since all surveys obligations are user specific, all the information you query here must be specific to the current user
5) Unauthorized access should yield an error response in JSON
6) Any survey obligation/definition returned should have all fields EXCEPT user_id (if applicable), updated_at, and created_at
=end

end