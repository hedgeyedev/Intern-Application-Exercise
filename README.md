Intern-Application-Exercise
===========================

Welcome prospective intern!

This is the intern version of https://github.com/hedgeyedev/Developer-Applicant-Exercise which is the 1st step of the intern interview process at [Hedgeye](http://www2.hedgeye.com).  There are 2 purposes for this exercise:
1. Expose the prospective intern to the technologies (Ruby, Rails, Git)/process(Pull Requests) that will be employed in the internship
2. A test of the interns ability to follow directions and execute.

# Instructions

1. Fork this repository
2. In the *pick_me* directly
   * Add a file pick_me.txt which describes why we should choose you as an intern.  It would be nice to stand out, but a fallback would be typical cover letter type verbiage.  Include why you think our internship is interesting to you.
   * (Optional) Anything else you want us to know, resume, portfolio, etc. is appropriate. 
3. In the blog directory, create a simple Ruby on Rails scaffold based blog.  you will have to do the following
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

# When you're done

1. Commit and Push your code to your fork
2. Send a pull request, we will review your code and get back to you.  If your GitHub profile does not include your name, please include your name in the pull request.


Good luck!
---------
 
