/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
 (function(){

     /**
      *
      */
     ActionBar = function($container) {
         this.$container = $($container);

         this.$new      = $(".new-post", this.$container);
         this.$save     = $(".save-post", this.$container);
         this.$home     = $(".all-posts", this.$container);
         this.$back     = $(".back", this.$container);
         this.$delete   = $(".delete-post", this.$container);
         this.$edit     = $(".edit-post", this.$container);

         this.initActionBarListeners();
     };

     ActionBar.prototype.$ = function() {
         return this.$container;
     };

     /**
      * Hides all actions button
      */
     ActionBar.prototype.updateActionBar = function(templateName) {

        this.hideAllActionButtons();

        switch (templateName) {
            case 'new' :
                this.$back.show();
                this.$home.show();
                this.$save.show();

                break;
            case 'index':
                this.$new.show();
                break;
            case 'edit':
                this.$back.show();
                this.$save.show();
                this.$home.show();
                break;
            case 'show':
                this.$delete.show();
                this.$edit.show();
                this.$home.show();
                //this.showActionButton('.comments');

                break;
            case 'index-all':
                this.$home.show();
                this.$new.show();
                
                //this.showActionButton('.comments');

                break;
        }

    };

    /**
     *  Hides all action buttons
     */
    ActionBar.prototype.hideAllActionButtons = function() {
        $(".button", this.$container).hide();
    };

    /**
     *  Inits the action listeners
     */
    ActionBar.prototype.initActionBarListeners = function () {

        /**
         * displays form for new post : callback "/posts/new.js.erb"
         */
        this.$new.click(function(){

            this.$container.data("back-action",myBlog.currentTemplate);

            Blog.loading(Blog.$wallContainer);
            controller.newPost();

        }.bind(this));

        /**
         * submits form for new post : callback "/posts/create.js.erb" or "/posts/show.js.erb"
         */
        this.$save.click(function(){

             Blog.loading(Blog.$wallContainer);

             if($("form.new_post").length > 0 ) {
                 $("form.new_post").submit();
             }
             else if($("form.edit_post").length > 0) {
                 $("form.edit_post").submit();
             }

        });


        /**
         * unused
         */
        $(".reset-form", this.$container).click( function(){
             if($("form.new_post").length > 0 ) {
                 $("form.new_post").trigger('reset');

             }
             else if($("form.edit_post").length > 0) {
                 $("form.edit_post").trigger('reset');
             }

             $(".field-error").removeClass("field-error");

             $("#notice").MyUInotice("close");

        });

        /**
         * Triggers the back action according to last template visited
         * can use callback /posts/index.js.erb
         */
        this.$back.click(function(){
            var backAction = this.$container.data("back-action");
            switch(backAction) {
                case 'index' :
                    myBlog.getPosts();
                break;
                case 'show' :
                    myBlog.toggleWallContent('post');

                break;

            }

            myBlog.changeTemplate(backAction, myBlog.currentPostId);

        }.bind(this));


        /**
         * Goes to the wall
         */
        this.$home.click(function(){

             if (myBlog.isDirty("all-posts")) {
                myBlog.setAllPosts();
             }
             else {
                myBlog.toggleWallContent('all-posts');
                myBlog.changeTemplate('index');
             }

        }.bind(this));

        /**
         * Triggers delete of current displayed postpost
         * callback /posts/index.js.erb
         */
        this.$delete.click(function(){
              if(confirm("Are you sure?")) {
                Blog.loading(Blog.$wallContainer);
                controller.deletePost(myBlog.currentPostId);
              }

        }.bind(this));

        /**
         * Opens the edit template for the selected post
         */
        this.$edit.click(function(){
          this.$container.data("back-action",myBlog.currentTemplate);
          Blog.loading(Blog.$wallContainer);
          controller.editPost(myBlog.currentPostId);
        }.bind(this));

        /**
         * Observes template changes
         */
        $(document).bind("blog:template-changed", function(evt,templateName){
            this.updateActionBar(templateName);
        }.bind(this))


    };
 })()

