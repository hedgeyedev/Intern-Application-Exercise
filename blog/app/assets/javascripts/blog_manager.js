/* 
 *
 */

(function(){

    Blog  = function(){

        this.$moreLink = $('<a href="#" class="more-link">all posts</a>');

        this.currentTemplate = "index";

        //Id of displayed post
        this.currentPostId = null;

        //Init the login button
        if (this.isBlogOwner()) {
            $(".auth.button").removeClass("login");
            $(".auth.button").attr("title","logout");
        }
        else {
            $(".auth.button").addClass("login");
            $(".auth.button").attr("title","login");
        }

        $("body").attr("auth-disabled",!this.isBlogOwner());

    };

    Blog.prototype.isBlogOwner = function() {
              return window.sessionStorage.getItem("logged-in");
    }
//************************************************************************
// Post related functions

    /**
     * Appends a preview post into the main container
     * Post is built from a JSON object
     *
     * @params jsonPost
     */
    Blog.prototype.appendPost = function(jsonPost) {
        var $post = new Post({post: jsonPost}).$();
        $post.children().tooltip();
        Blog.$allPostsContainer.append($post)
    };

    /**
     * Appends a list of preview posts into the main container
     *
     * @params jsonPosts: the list of JSON objects
     */
    Blog.prototype.appendAllPosts = function(jsonPosts) {

        for(var i = 0 ; i < jsonPosts.length; i++) {
            this.appendPost(jsonPosts[i])
        }
     
    };

    /**
     *  Sets the single and expande post into the main container
     *  @param $post: post element (@see post.js)
     */
    Blog.prototype.setSinglePost = function($post) {
        Blog.$singlePostContainer.empty();
        $post.children().tooltip();
        Blog.$singlePostContainer.append($post);
    }

    /**
     * Appends Post form
     * @param $formElm : form dom element
     */
    Blog.prototype.appendForm = function($formElm) {
            
       Blog.$formPostContainer.empty();
       Blog.$formPostContainer.append($formElm);
 
    };

    /**
     *  Flushes the main container and load the new posts
     *
     *  @see callback function: load.js.erb
     */
    Blog.prototype.setAllPosts = function() {
        this.flushWall();
        this.getPosts();
    },

    /**
     * Call controller method
     */
    Blog.prototype.getPosts = function(options) {
        Blog.loading(Blog.$wallContainer);
        controller.getPosts(options);
    },

    Blog.prototype.getPost = function(postId) {
        Blog.loading(Blog.$wallContainer);
        controller.getPost(postId);
    },

    /**
     *  Removes a post element from the dom
     *
     *  @param postId
     */
    Blog.prototype.removePost = function(postId) {
        $("#post-id-"+postId).remove();
    };

    /**
     * Flushes the container of single post expanded
     */
    Blog.prototype.flushPost = function() {
       Blog.$singlePostContainer.empty();
    };

    /**
     * Listener for events of post objects
     */
    Blog.prototype.initPostListeners = function() {
        var blogObj = this;

        /**
         * open a post @see callback /posts/show.js.erb
         */
        $(document).bind("post:read-more",function(evt, jsonPost, $post) {

            blogObj.getPost(jsonPost.id);

        });

        /**
         * close a post @see callback /posts/index.js.erb
         */
        $(document).bind("post:read-less",function(evt, jsonPost, $post) {

            if (blogObj.isDirty('all-posts')) {
                blogObj.getPosts();
            }
            else {
              blogObj.toggleWallContent('all-posts');
              blogObj.changeTemplate("index");
            }

        });

        /**
         * read all comments of a post @see callback /comments/index.js.erb
         */
        $(document).bind("post:read-comment",function(evt, jsonPost, $post) {

           controller.getComments(jsonPost.id);

        });
    };
//************************************************************************
// Main containers related functions

    /**
     * Add link to show all posts
     */
    Blog.prototype.setMoreLink = function(limit) {

        if ($(".post",Blog.$allPostsContainer).length >= limit) {
            Blog.$allPostsContainer.append(this.$moreLink);
                this.$moreLink.click(function(){
                    this.getPosts({all:true});
                }.bind(this));

        }
        
    };

    /**
     * Flushes container of all posts
     */
    Blog.prototype.flushWall = function() {
        Blog.$allPostsContainer.empty();
    };

    /**
     * Sets dirty flag on main containers
     * @params what : the container @see static containers;
     * @params isDirty
     */
    Blog.prototype.setDirty = function(what, isDirty) {
        var elm;
        switch (what) {
          case 'post':
           elm = Blog.$singlePostContainer;

          break;

          case 'all-posts' :
           elm = Blog.$allPostsContainer;

          break;

          case 'form' :
           elm = Blog.$formPostContainer;

          break;
        }

        elm.data("is-dirty",isDirty);
    };

    /**
     *  Getter isDirty flag
     */
    Blog.prototype.isDirty = function(what) {
        switch (what) {
            case 'post':
                return Blog.$singlePostContainer.data("is-dirty");

            break;

            case 'all-posts' :
                return Blog.$allPostsContainer.data("is-dirty");

            break;

            case 'form' :
                return Blog.$formPostContainer.data("is-dirty");

            break;
        }

    };

    /**
     * Changes the visibility of main containers [post, all-posts, form]
     * and scrolls on top of page
     */
    Blog.prototype.toggleWallContent = function(what, retainNotice) {

        Blog.$commentsSection.hide();

        switch (what) {
          case 'post' :
            Blog.$formPostContainer.hide();
            Blog.$allPostsContainer.hide();
            Blog.$singlePostContainer.show();

          break;

          case 'all-posts' :

            Blog.$formPostContainer.hide();
            Blog.$allPostsContainer.show();
            Blog.$singlePostContainer.hide();

          break;

          case 'form' :
            Blog.$singlePostContainer.hide();
            Blog.$allPostsContainer.hide();
            Blog.$formPostContainer.show();

          break;
        }


        if (!retainNotice) {
            Blog.$notice.MyUInotice("clear");
        }

        this.scrollOnTop(50);

    };
    
    /**
     * Changes page templates for driving the display of action bars
     * and context related data (postId of current post)
     */
    Blog.prototype.changeTemplate = function(template, postId){
      this.currentTemplate = template;
      this.currentPostId = postId;

      //to update action bar
      $(document).trigger("blog:template-changed",template);
      
    };


    /**
     * Hide/Show empty wall
     * @param isShow : boolean
     */
    Blog.prototype.setEmptyWall = function(){
          Blog.$allPostsContainer.html(this.createEmptyMessageElm('Nothing...'));
          
    };



//************************************************************************
// Miscellaneous functions

    /**
     *  Open a widget based modal popup  @see jquery-plugin.js
     */
    Blog.prototype.openPopup = function(content, popupTitle) {

          Blog.$popupContainer.MyUIwidget({type:"dialog"});
          Blog.$popupContainer.MyUIwidget("header",popupTitle);
          Blog.$popupContainer.MyUIwidget("body",content);
          Blog.$popupContainer.MyUIwidget("open");

    };

    /**
     *  Scrolls on topo of page with animation;
     */
    Blog.prototype.scrollOnTop  = function(triggerTop, callback) {
        var top = triggerTop || -1;
        if (Blog.$bodyWrapper.scrollTop() > top) {
            Blog.$bodyWrapper.animate({scrollTop : 0}, 300, callback);
        }
    };

    /**
     * Hide Show loader for the specified container
     */
    Blog.loading = function($container,isShow){
          if (isShow || isShow === undefined ) {
              $container.append('<div class="loader"/>');
          }
          else {
             $(".loader",$container).remove();
          }

    };


//************************************************************************
// Login functions

      Blog.prototype.initLoginListener = function() {

         var thisObj = this;

         $(".auth").click(function() {
                if($(this).hasClass("login")) {
                     controller.login(function(){
                        thisObj.changeTemplate(thisObj.currentTemplate, thisObj.currentPostId);
                        $(this).toggleClass("login");
                        $(this).tooltip("option","content","logout");
                        $("body").attr("auth-disabled",false);
                     }.bind(this));
                }
                else {
                    controller.logout(function(){
                        if(thisObj.currentTemplate == 'new' ||
                            thisObj.currentTemplate == 'edit') {

                            if( confirm("All modifications will be lost! Do you want to continue?")) {

                                 if (thisObj.currentTemplate == 'new') {
                                     thisObj.getPosts();
                                 }
                                 else {
                                     thisObj.getPost(thisObj.currentPostId);
                                 }
                                 thisObj.changeTemplate(thisObj.currentTemplate, thisObj.currentPostId);
                                $(this).toggleClass("login");
                                $(this).tooltip("option","content","login");
                            }

                        }
                        else {
                            thisObj.changeTemplate(thisObj.currentTemplate, thisObj.currentPostId);
                            $(this).toggleClass("login");
                            $(this).tooltip("option","content","login");
                        }

                        $("body").attr("auth-disabled",true);

                    }.bind(this));
                }

         });

      };

     /**
     *  empty message element
     */
    Blog.prototype.createEmptyMessageElm = function (msg) {
        return $('<span class="empty-message">'+msg+'</span>')
    };

    Blog.prototype.refeshWidgets = function () {
        controller.getMostPopular("html");
        controller.getLatestComments()
    }

//************************************************************************
// Comments related functions


    /**
     * Init listeners for events related to comment objects
     */
    Blog.prototype.initCommentListener = function() {

        var thisObj = this;
        /**
         * delete a cooment @see callback: /comments/destroy.js.erb
         */
        $(document).on("click",".comments .delete", function(evt){
           if (confirm("Delete this comment?")) {
               var jsonComment = $(this).parents(".comment-box").data("json");
               $(this).parents(".comment-box").trigger("comment:delete", $(this).data("json"));
               controller.deleteComment(jsonComment.id,jsonComment.post_id);
           }
        });

        /**
         * submit a new comment @see callback /comments/create.js.erb
         */
        $(document).on("click",".save-comment", function(evt){

           controller.submitNewCommentForm($("form#new_comment"));
           //$("form#new_comment").submit();

        });

        /**
         * shows the post releted to comment clicked into the latest comment widget
         */
        Blog.$latestCommentsWidget.on("click",".comment-box", function(){
           var postId = $(this).data("json").post_id;
           thisObj.getPost(postId);
        });

    };

    /**
     * Populates and return the provided container with comment objects built
     * from a JSON array
     *
     * @param jsonComments: JSON representing a comment
     * @param $container: to container into which append the comments
     * @param options { animate : boolean,
     *           duration : int
     *           type : (prepend|append)
     *           commentsOptions : {deletable :boolean}
     *           }
     */
    Blog.prototype.populateCommentsContainer = function(jsonComments, $container, options) {

        $container.empty();
        $.each(jsonComments, function(idx, jsonComment) {

            this.prependComment(jsonComment, $container, options);
        }.bind(this));

        return $container;
    };

    /**
    * prepends or appends comment whith or without animation specified via
    * options @see Blog#populateCommentsContainer
    *
    */
    Blog.prototype.prependComment = function(jsonComment, $container, options) {

        options = $.extend({},options);
        var $comment = new Comment(jsonComment,options.commentOptions).$();

        $comment.hide();
        if (options.type == 'append') {
            $container.append($comment);
        }
        else {
            $container.prepend($comment);
        }

        if (options.animate) {
            var duration = options.duration || 500;
            $comment.show("blind" , {direction: "vertical"}, duration);
        }
        else {
            $comment.show();
        }
    };

//************************************************************************
// Widgets

    /**
     * Init widgets
     */
    Blog.prototype.initWidgets = function() {

        this.initMostPopularWidget();
        
        this.initSearchWidget();

        this.initCommentsWidget();

        Blog.$sideContent.sortable({handle: "header"});

    };

    /**
     * Init mostPopular widget
     * Load posts with more readers @see callback /posts/popular
     * every minute
     */
    Blog.prototype.initMostPopularWidget = function() {
        Blog.$mostPopularWidget.MyUIwidget();
        var $header = $('<div class="title">Popular&nbsp;</div><div class="refresh" style="display:none"><a href="posts/popular/refresh" data-remote="true"></a></div>');
        Blog.$mostPopularWidget.MyUIwidget("header",$header);
        controller.getMostPopular();

        var poll = new Poll(Blog.MOST_POPULAR_INTERVAL, controller.getMostPopular, "html");
        poll.startPolling();

    };

    /**
     * Init search widget
     * Provide a simple form to perform a simple like search on post title and
     * body
     */
    Blog.prototype.initSearchWidget = function() {
        Blog.$searchWidget.MyUIwidget();
        $header = "Search"
        Blog.$searchWidget.MyUIwidget("header",$header);
        Blog.$searchWidget.MyUIwidget("body",'<input type="text" name="search-post" id="search-post" placeholder="search" title="empty text to get all posts"/>'+
                                              '<div id="search-button" class="button" title="search"><a href="#"></a></div>');

        Blog.$searchButton          = $("#search-button");
        Blog.$searchInput           = $("input#search-post");

        Blog.$searchInput.tooltip();

    };

    /**
     * Init comments widget
     * Load the most recent comments @see callback /comments/latest
     * every ten seconds
     *
     */
    Blog.prototype.initCommentsWidget = function() {
        Blog.$latestCommentsWidget.MyUIwidget();
        $header = "Last comments"
        Blog.$latestCommentsWidget.MyUIwidget("header",$header);
        controller.getLatestComments();
        var poll = new Poll(Blog.LATEST_COMMENT_INTERVAL, controller.getLatestComments,"","");
        poll.startPolling();
    };


    /**
     * 
     */
    Blog.prototype.init = function() {
        this.getPosts();
        controller.getMostPopular('html');
        this.changeTemplate("index");
        this.initPostListeners();
        this.initLoginListener();
        this.initCommentListener();

        this.initWidgets();

        $(".button").tooltip({position: {my: "left top+5", at: "left bottom", collision: "flipfit"}});

        $(document).bind("post:edit",function(evt, postId, $post) {
           controller.submitEditPostForm($("#post-form"),postId);
        });

        Blog.$searchButton.click(function(){

           this.getPosts({search: Blog.$searchInput.val()});
        }.bind(this));

        Blog.$searchInput.keypress(function(e) {
            if(e.which == 13) {
               this.getPosts({search: Blog.$searchInput.val()});
            }
        }.bind(this));
    };



    Blog.LATEST_COMMENT_INTERVAL = 30000;

    Blog.MOST_POPULAR_INTERVAL = 10000;

})()

$(document).ready(function(){
    //Static dom elements
    Blog.$commentsSection       = $("#comments-section");
    Blog.$popupContainer        = $("#popup-container");
    Blog.$bodyWrapper           = $("#body-wrapper");
    Blog.$notice                = $("#notice");

    Blog.$singlePostContainer   = $("#single-post");
    Blog.$allPostsContainer     = $("#all-posts");
    Blog.$formPostContainer     = $("#form-post");
    
    Blog.$mostPopularWidget     = $("#most-popular-box");
    Blog.$searchWidget          = $("#search-box");
    Blog.$latestCommentsWidget  = $("#latest-comments-box");
    
    Blog.$sideContent           = $("#side-content");
    Blog.$wallContainer         = $("#blog-wall");

    
    myBlog = new Blog();
    
    actionBar = new ActionBar("#action-bar");

    myBlog.init();
     

});


