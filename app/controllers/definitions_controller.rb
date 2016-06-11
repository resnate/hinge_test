class DefinitionsController < ApiController
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
	end

	def submittable_now
	end

	def due
	end
end