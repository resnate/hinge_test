Rails.application.routes.draw do

  #We want: GET api/v1/surveys/:id OR :name -> single survey identified by id OR name
  root "surveys#home"
  namespace :api, :defaults => {:format => :json} do
  	namespace :v1 do
  		scope '/surveys' do
  			get "/:identifier" => "surveys#show"
  			get "/due_this_week" => "surveys#due_this_week"
  			get "/submittable_now" => "surveys#submittable_now"
  			get "/missed" => "surveys#missed"
  			get "/due/:week_index" => "surveys#due"
  			post "/submit/:name" => "surveys#submit"
  			scope '/definitions' do
  				get "/:identifier" => "definitions#show"
  				get "/due_this_week" => "definitions#due_this_week"
  				get "/submittable_now" => "definitions#submittable_now"
  				get "/missed" => "definitions#missed"
  				get "/due/:week_index " => "definitions#due"
  			end
  		end		
  	end
  end
  
  #We want: GET api/v1/surveys/due_this_week -> list of surveys due this week, regardless of submission state
  #We want: GET api/v1/surveys/submittable_now -> list of unsubmitted surveys for which the current time is between due_at and expires_at
  #We want: GET api/v1/surveys/missed -> list of all surveys meant to be submitted but without submission
  #We want: GET api/v1/surveys/due/:week_index -> list of all survey whose definitions declare a week index equal to the one in the url

  #for ALL of the routes above, adding /definitions right after '/surveys/' should return the list of corresponding definitions INSTEAD of the obligations WITHOUT duplicates
  # for instance, api/v1/surveys/definitions/due_this_week is valid
  #a request without /definitions returns the list of obligations themselves

  #We want: POST api/v1/surveys/submit/:name -> where :name is the definition name. Since only one obligation of a survey may exist per week per person, you should be able to get a handle on that obligation using just the name.
  # You should of course handle illegal submission attempts.
  #A submission JSON body could look like {question_1: answer_1, ..., question_n: answer_n}
  #By the time you render a response, you should have the_appropriate_obligation.submission ==> {question_1: answer_1, ..., question_n: answer_n}


end