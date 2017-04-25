Intern-Application-Exercise
===========================

Welcome prospective intern!

This is the intern version of https://github.com/hedgeyedev/Developer-Applicant-Exercise which is the 1st step of the intern interview process at [Hedgeye](http://www2.hedgeye.com). The purposes for this exercise are twofold:

1. Expose the prospective intern to some of the technologies (Ruby, Rails, Git)/process(Pull Requests) that will be used daily in the internship.
2. A test of the interns ability to follow directions and execute.  Often a resume and/or cover letter don't fairly represent what the intern is capable of, this exercises hopefully helps show what an intern can do.

# Instructions

1. Fork this repository
2. In the *pick_me* directory
   * Add a file pick_me.txt which describes why we should choose you as an intern.  It would be nice to stand out, but a fallback would be typical cover letter type verbiage.  Include why you think our internship is interesting to you.
   * (Optional) Anything else you want us to know, resume, portfolio, etc. is appropriate.
3. In the blog directory, create a simple Ruby on Rails scaffold based blog.  you will have to do the following
   * setup your computer for Ruby on Rails development.  For windows, and older than Mavericks versions of OSX [Rails Installer](http://railsinstaller.org/en) is the easiest. [Go Rails](https://gorails.com/setup) is a more technical and covers Windows 10, OSX and Ubuntu. If you're running a different version of Linux, you probably know what to do.
   * Create a rails project in the blog directory

            $ rails new blog

   * Go into the blog directory and start

            $ cd blog

   * Create a scaffold for your blog

            $ rails generate scaffold Post title:string content:text
            $ rake db:migrate

   * Setup your routes to go to the blog index by changing config/routes.rb to

            Rails.application.routes.draw do
               resources :posts
               root :to => "posts#index"
            end

   * Run the server and when it's up [check it out](http://localhost:3000)

            $ rails s

   * Congratulations, you now have a functional but "butt ugly" (the technical term) blog, make it a little less ugly and clunky. Do what you can. Suggestions:
       - Better (any) styling
       - Change of labels
       - Change of layout - have the index look more like a blog showing the whole blog article, or a larger portion with a "read the rest"
       - Additional functionality, esp. that showing Ruby and/or other web development skills for extra credit

# When you're done

1. Commit and Push your code to your fork
2. Send a pull request, we will review your code and get back to you.  If your GitHub profile does not include your name, please include your name in the pull request.


Good luck!
---------
