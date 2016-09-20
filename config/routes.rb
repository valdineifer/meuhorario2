Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#index'
  get 'curso/:code' => 'courses#show', :as => 'course_page'
  get 'clear_db' => 'application#clear_db', :as => 'clear_db'
  get 'crawl_courses' => 'application#crawl_courses', :as => 'crawl_courses'
  get 'crawl_disciplines' => 'application#crawl_disciplines', :as => 'crawl_disciplines'
  get 'crawl_pre_reqs' => 'application#crawl_pre_reqs', :as => 'crawl_pre_reqs'
  get 'crawl_cs' => 'application#crawl_cs', :as => 'crawl_cs'
  get 'crawl_cs_classes' => 'application#crawl_cs_classes', :as => 'crawl_cs_classes'
  get 'crawl_classes' => 'application#crawl_classes', :as => 'crawl_classes'
  get 'titleize_disciplines' => 'application#titleize_disciplines', :as => 'titleize_disciplines'
end
