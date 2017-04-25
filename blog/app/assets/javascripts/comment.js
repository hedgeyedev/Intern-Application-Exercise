/**
 * Creates a component from a JSON object, representing a Comment to a Post
 * @see comment.css.scss for sytling
 */
(function(){

    Comment = function(jsonComment, prop) {

       this.defSettings = {deletable: true};

       this.settings = $.extend({}, this.defSettings,prop);

       this.$comment = $("<div class='comment-box'/>");
       this.$commenter  = $("<span class='commenter'/>");
       this.$body = $("<div class='body'/>");
       this.$delete = $("<div class='delete auth-aware'/>");
       this.$createdAt = $("<span class='created-at'/>");

       this.$commenter.text(jsonComment.commenter);
       this.$body.text(jsonComment.body);
       this.$createdAt.text(" wrote on " + jsonComment.created_at_formatted);

       this.$comment.append(this.$commenter);
       this.$comment.append(this.$createdAt);
       this.$comment.append(this.$body);

       if (this.settings.deletable) {
            this.$comment.append(this.$delete);
       }

       this.$comment.data("json", jsonComment);

       this.$comment.attr("id","comment-id-"+jsonComment.id)

    };

    Comment.prototype.$ = function() {
        return this.$comment;
    }
})();

