class SurveysController < ApiController
	
	def show
		if Survey.where(id: params[:identifier]).count > 0
			@type = "id"
			@id = params[:identifier]
		elsif Survey.where(id: params[:identifier]).count > 0
			@type = "name"
			@name = params[:identifier]
		else
			render text: '{"error": "not_found"}'
		end
	end

	def due_this_week
		paginate json: @results, per_page: 5
	end

	def submittable_now
		paginate json: @results, per_page: 5
	end

	def due
		if Survey.where(id: params[:identifier]).count > 0
		else
			render text: '{"error": "not_found"}'
		end
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