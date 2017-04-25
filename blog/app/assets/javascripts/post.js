/**
 * Creates a component from a JSON object, representing a Post
 * It can display a list of comments
 * @see post.css.scss for sytling
 *
 */
(function(){

    Post = function (options) {

       this.post     = options.post;
       this.expanded = options.expanded;

       this.$post           = $('<div class="post"/>').data("post-json",this.post);
       this.$header         = $('<header/>');
       this.$subHeader      = $('<div class="sub-header"/>');
       this.$title          = $('<span class="title">').text(this.post.title);
       this.$content        = $('<div class="content">').text(this.post.content);
       this.$actionDiv      = $('<div class="action-div"/>');
       this.$expand         = $('<div class="expand"/>');
       this.$readComment    = $('<div class="read-comment"/>');
       this.$collapse       = $('<div class="collapse"/>');

       this.$comments       = $('<div class="comments"/>');
       this.$commentsHeader = $('<div class="comments-header"/>');
       this.$commentsTitle  = $('<div class="title"/>');
       this.$commentsSave   = $('<div class="button save-comment"><a href="#"></a></div>');
       this.$commentsContent  = $('<div class="comments-content"/>');

       this.$commentForm    = $('<div class="post-comment-form">');

       this.$post.attr("id","post-id-"+this.post.id);

       if (this.expanded) {
         this.$post.addClass("expanded");
       }

       this.$header.append(this.$title)
       this.$subHeader.text(this.post.updated_at_formatted)
       //this.$subHeader.text(this.post.updated_at)
       this.$post.append(this.$subHeader);


       this.$post.append(this.$header)
       this.$post.append(this.$content)

       this.$actionDiv.append(this.$expand);
       this.$actionDiv.append(this.$readComment);
       this.$actionDiv.append(this.$collapse);
       this.$post.append(this.$actionDiv);
       this.$post.append(this.$comments);

       this.$commentsHeader.append(this.$commentsTitle);
       this.$commentsHeader.append(this.$commentsSave);

       this.$commentsTitle.text("Comments");
       this.$comments.append(this.$commentsHeader);
       this.$comments.append(this.$commentsContent);
       this.$comments.toggle(this.expanded);

       this.initListeners(options);

       // set tooltip values
       if(this.post.no_of_comments <= 0) {
         this.$readComment.addClass("disabled");
         this.$readComment.attr("title","no comment");
       }
       else {
         this.$readComment.attr("title",this.post.no_of_comments + " comments");
       }

       this.$expand.attr("title","Open post");
       this.$collapse.attr("title","Close post");

       this.$post.data("post-obj", this);

       this.$commentsSave.attr("title","save comment");
       this.$commentsSave.tooltip();

     };

     Post.prototype.setCommentForm = function($form) {
         this.$commentForm.html($form);
         this.$commentsHeader.after(this.$commentForm);
     }

     Post.prototype.initListeners = function(options) {
        var thisObj = this;
        this.$post.on("click",".expand, .title", function() {
           if( !thisObj.$post.hasClass("expanded")) {
               $(this).trigger("post:read-more", [thisObj.$post.data("post-json"),thisObj.$post]);
           }
        });

        thisObj.$post.on("click",".read-comment", function() {

           if (!$(this).hasClass("disabled")) {

                $(this).trigger("post:read-comment", [thisObj.$post.data("post-json"),thisObj.$post]);
           }

        });

        thisObj.$post.on("click",".collapse", function() {
           $(this).trigger("post:read-less", [thisObj.$post.data("post-json"),thisObj.$post]);
        });


     };

     Post.prototype.setContent = function(content) {
         this.$content.text(value);
     };

     Post.prototype.getContent = function() {
         return this.$content.text();
     };

     Post.prototype.expand = function(excludeComments) {
         this.$post.addClass("expanded");
         if(!excludeComments) {

             this.showComments();
         }
         
     };

     Post.prototype.collapse = function(excludeComments) {
         this.$post.removeClass("expanded");
         if(!excludeComments) {
             this.hideComments();
         }
     };

     Post.prototype.populateComments = function(jsonComments) {

         $.each(jsonComments, function(idx,jsonComment) {
             var comment = new Comment(jsonComment);
             this.$commentsContent.append(comment.$());
         }.bind(this));

         if (jsonComments.length > 0) {
             this.$comments.show();
         }
         
     };

     Post.prototype.showComments = function() {
         this.$comments.show();
     }

     Post.prototype.hideComments = function() {
         this.$comments.hide();
     }

     Post.prototype.$ = function() {
         return this.$post;
     }

})();

