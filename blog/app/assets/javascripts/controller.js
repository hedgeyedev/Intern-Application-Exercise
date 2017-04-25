/* 
 * Application controller
 */
(function(){
    Controller = function(){};

    /**
     *  callback /posts/load.js and.erb /posts/search.js.erb
     *  arguments.empty: load all posts
     *  arguments[0] = {search:value} filter post by like in title and body
     */
    Controller.prototype.getPosts = function(options) {


       var action = "/posts/load";
       var callback = typeof arguments[0] === 'function'? arguments[0] : arguments[1];

       if( options && options.search) {
           action = "/posts/search/"+options.search;
       }
       else if( options && options.all) {
           action = "/posts/all";
       }

       $.ajax(action);


    };

    /**
     * Get a single post by id
     * callback /posts/show.js.erb
     */
    Controller.prototype.getPost = function(id, callback) {
       var action = "/posts/"+id;

        $.ajax(action, function(jsonPosts){
          if (callback) {
              callback(jsonPosts);
          }
       });

    };

    /**
     * Delete a post
     * callback /posts/load.js.erb
     */
    Controller.prototype.deletePost = function(id) {
       var action = "/posts/"+id;
       var method = "DELETE"

       $.ajax(action, {type : method});

    };

    /**
     * Prepare new Post
     * callback /posts/new.js.erb
     */
    Controller.prototype.newPost = function(id) {
       var action = "/posts/new";

       $.ajax(action);

    };

    /**
     * Prepare a Post for editing
     * callback /posts/edit.js.erb
     */
    Controller.prototype.editPost = function(id) {
       var action = "/posts/"+id+'/edit';


       $.ajax(action);

    };

    /**
     * Update a post
     * callback /posts/after_edit.js.erb
     */
    Controller.prototype.updatePost = function(id) {
       var action = "/posts/"+id;
       var method = "POST"

       $.ajax(action, {type: method});

    };

    /**
     * Load most read posts
     * callback /posts/popular.js.erb
     */
    Controller.prototype.getMostPopular = function(dataType) {
       var action = "/posts/popular";
       if(dataType == 'json') {
           action += '.json';
       }
       $.ajax(action);
   
    };

    /**
     * Delete a comment
     * callback /comments/destroy.js.erb
     */
    Controller.prototype.deleteComment = function(id,postId) {
       var action = "/posts/"+postId+"/comments/"+id;
       
       $.ajax(action,{type: "DELETE"});


    };

    /**
     * Prepare new comment
     * callback /comments/new.js.erb
     */
    Controller.prototype.newComment = function(postId) {
       var action = "/posts/"+postId+"/comments/new";

       $.ajax(action);


    };

    /**
     *  Get Post comments
     *  callback /comments/index.js.erb
     */
    Controller.prototype.getComments = function(postId) {
       var action = "/posts/"+postId+"/comments";

       $.ajax(action);


    };

    /**
     *  Get most recent comments
     *  callback /comments/latest.js.erb
     */
    Controller.prototype.getLatestComments = function(timeB, timeE) {
       var action = "/comments/latest/"+timeB+"/"+timeE;

       $.ajax(action);


    };


    /**
     *  Set form action and submit it
     *  callback /comments/latest.js.erb
     */
    Controller.prototype.submitEditPostForm = function($form, id) {
       $form.attr("/posts/"+id+"/edit");
       $form.submit();


    };

    /**
     *  Set form action and submit it
     *  callback /comments/latest.js.erb
     */
    Controller.prototype.submitNewCommentForm = function($form) {
       $form.submit();

    };

    /**
     *  Go to index page
     */
    Controller.prototype.restart = function() {
       var $form =  $('<form action="/posts" method="GET" style="display:none"/>');
       $("body").append($form);
       $form.submit();

    };

    /**
     * FAKE LOGIN
     */
    Controller.prototype.login = function(callback) {
       if (window.sessionStorage) {
           window.sessionStorage.setItem("logged-in",true);
       }
       if(callback) {
         callback();
       }

    };

    /**
     * FAKE LOGOUT
     */
    Controller.prototype.logout = function(callback) {
       if (window.sessionStorage) {
           window.sessionStorage.removeItem("logged-in");
       }
       if(callback) {
         callback();
       }

    };

    controller = new Controller();
})()


