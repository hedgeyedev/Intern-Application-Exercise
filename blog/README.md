# A Quick and Dirty Rails based blog

   * setup your computer for Ruby on Rails development.  [Rails Installer](http://railsinstaller.org/) is a good start point for Windows and OSX, if you're running Linux, I imagine you know how to use your package manager to set it up.  This [setup for Ubuntu](http://coding.smashingmagazine.com/2011/06/21/set-up-an-ubuntu-local-development-machine-for-ruby-on-rails/) might be a good start point.
   * Create a rails project in the blog directory

            $ rails new blog

   * Go into the blog directory and start

            $ cd blog

   * Create a scaffold for your blog

            $ rails generate scaffold Post title:string content:text
            $ rake db:migrate

        
   * Remove the index.html
   
       $ rm public/index.html
       
   * Setup your routes to go to the blog index by changing config/routes.rb to 
   
            App::Application.routes.draw do
               resources :posts
               root :to => "posts#index"
            end
       
   * Run the server and when it's up [check it out](http://localhost:3000)
   
            $ rails s
       
   * Congratulations, you now have a functional but "butt ugly" (the technical term) blog, make it a little less ugly and clunky. Do what you can. Suggestions:
       - Better (any) styling
       - Change of labels
       - Change of layout - have the index look more like a blog showing the whole blog article, or a larger portion with a "read the rest"
