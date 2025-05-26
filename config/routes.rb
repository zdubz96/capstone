Rails.application.routes.draw do

  # Routes for the Topic resource:

  # CREATE
  post("/insert_topic", { :controller => "topics", :action => "create" })
          
  # READ
  get("/topics", { :controller => "topics", :action => "index" })
  
  get("/topics/:path_id", { :controller => "topics", :action => "show" })
  
  # UPDATE
  
  post("/modify_topic/:path_id", { :controller => "topics", :action => "update" })
  
  # DELETE
  get("/delete_topic/:path_id", { :controller => "topics", :action => "destroy" })

  #------------------------------

  # Routes for the Question resource:

  # CREATE
  post("/insert_question", { :controller => "questions", :action => "create" })
          
  # READ
  get("/questions", { :controller => "questions", :action => "index" })
  
  get("/questions/:path_id", { :controller => "questions", :action => "show" })
  
  # UPDATE
  
  post("/modify_question/:path_id", { :controller => "questions", :action => "update" })
  
  # DELETE
  get("/delete_question/:path_id", { :controller => "questions", :action => "destroy" })

  #------------------------------

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

  get("/quiz_sessions", to: redirect("/"))

end
