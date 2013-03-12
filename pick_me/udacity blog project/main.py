#!/usr/bin/env python
#
# Copyright 2007 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# enables interaction with operating system
import os
# regular expressions
import re

from string import letters
# i need this to use gae stuff
import webapp2
import jinja2

from google.appengine.ext import db

# set up html directory in /templates
template_dir = os.path.join(os.path.dirname(__file__), 'templates')
# set up jinja with said template directory
jinja_env = jinja2.Environment(loader = jinja2.FileSystemLoader(template_dir),autoescape = True)

# translates template to html
def render_str(template, **params):
    t = jinja_env.get_template(template)
    return t.render(params)

# Basic rendering engine from html, receives jinja template and renders it
class BlogHandler(webapp2.RequestHandler):
	def write(self, *a, **kw):
		self.response.out.write(*a, **kw)
	# passes render job to jinja template reader
	def render_str(self, template, **params):
		return render_str(template, **params)
	# writes rendered template to browser
	def render(self, template, **kw):
		self.write(self.render_str(template, **kw))
	# write function that replaces s.o.w
	

def render_post(response,post):
	response.out.write('<b>'+ post.subject + '</b><br>')
	response.out.write(post.content)

###udacity taught me THIS STUFF down here

# sets up parent database key that all the posts will be stored under
def blog_key(name = 'default'):
	return db.Key.from_path('blogs',name)

# Set up the database entry
class Post(db.Model):
	subject = db.StringProperty(required = True)
	content = db.TextProperty(required = True)
	created = db.DateTimeProperty(auto_now_add = True)
	last_modified = db.DateTimeProperty(auto_now = True)
	
	# renders the html through the BlogHandler
	def render(self):
		#Replace the python newline with html line break
		self._render_text = self.content.replace('\n','<br>')
		return render_str("post.html", p = self)

# Redirects initial page call to /blog
class RedirectPage(BlogHandler):
	def get(self):
		self.redirect("blog")
		
# Reads the first 10 blog posts and lists them
class MainPage(BlogHandler):
    def get(self):
		posts = db.GqlQuery("select * from Post order by created desc limit 10")
		self.render("front.html", posts = posts) 

# Takes post number and shows post with specific permalink number
class PostPage(BlogHandler):
	def get(self, post_id):
		key = db.Key.from_path('Post', int(post_id), parent=blog_key())
		post = db.get(key)
		
		if not post:
			self.error(404)
			return
		
		self.render("permalink.html", post = post)

# Adds new blog entry
class NewPost(BlogHandler):
	def get(self):
		self.render("newpost.html")
	def post(self):
		subject = self.request.get('subject')
		content = self.request.get('content')
		if subject and content:
			p = Post(parent = blog_key(), subject = subject,
			content = content)
			p.put()
			self.redirect('/blog/%s' % str(p.key().id()))
		else:
			error="Put subject and content please!"
			self.render('newpost.html', subject=subject, content=content, error = error)

app = webapp2.WSGIApplication([('/', RedirectPage),('/blog[/]?', MainPage),('/blog/([0-9]+)', PostPage),('/blog/newpost', NewPost)],debug=True)
