Rails.application.routes.draw do

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
  devise_for :users

  authenticated :user do
    root to: 'quiz_sessions#start', as: :authenticated_root
  end

  devise_scope :user do
    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  root to: redirect('/users/sign_in')

  post("/quiz_sessions", { :controller => "quiz_sessions", :action => "create" })

  get("/quiz_sessions/:quiz_session_id/questions/:number", { :controller => "quiz_sessions", :action => "question", :as => "quiz_session_question" })

  post("/quiz_sessions/:quiz_session_id/questions/:number/answer", { :controller => "quiz_sessions", :action => "submit_answer"})

end
