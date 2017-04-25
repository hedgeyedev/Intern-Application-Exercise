/* 
 * jQuery plugins
 * @see jquery-plugin.css for styling
 *
 */
(function($){

    /**
     *  Display a simple Notice element:
     *  - okresult for positive confirmation
     *  - error for error notification
     *  - info for generic notification
     */
    var MyUInotice = function() {
    this.defSettings = {
                        type : "okresult",
                        css : {
                            display : "none"
                            }

                        };


        this.settings = {};
        var thisObj = this;

        this._reset = function($elm) {
            $elm.empty();
            $elm.hide();
            $elm.removeClass("error okresult info");
        };

        this.methods = {

             /**
             * options: {type : (okresult|info|error)}
             */
            init : function(options){
                $this = $(this);

                thisObj.noticeContainer = $this.clone();

                thisObj.settings = $.extend({},thisObj.defSettings,options);
                $this.addClass(thisObj.settings.type);
                $this.css(thisObj.settings.css);
                $this.addClass("notice");

                var message = $("<div class='message'/>")
                message.html(thisObj.settings.msg);
                $this.append(message);

                var icon = $("<div class='icon'/>");
                $this.prepend(icon);

                var closeButton = $("<div class='delete'/>");
                $this.append(closeButton);

                closeButton.click(function(evt) {

                    $(this).parent(".notice").animate({opacity: 0},300)
                                                .animate({height: '0px'},200, function(){
                                                 thisObj._reset($(this));
                                                });
                });
                $this.attr("style",false);
                return $this;
            },

            clear : function() {
                thisObj._reset($(this));
            },

            close : function() {
                $(this).animate({opacity: 0},300)
                                .animate({height: '0px'},200, function(){
                                 thisObj._reset($(this));
                                });
            }
        };
    };

    /**
     *  MyUInotice plugin
     *
     */
    $.fn.MyUInotice = function( method ) {
        var noticeObj = this.data("controller-class");

        if(!noticeObj) {
                noticeObj = new MyUInotice();
                this.data("controller-class",noticeObj);

        }
            // Method calling logic
        if ( noticeObj.methods[method] ) {
          return noticeObj.methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
        } else if ( typeof method === 'object' || ! method ) {
          return noticeObj.methods.init.apply( this, arguments );
        } else {
          $.error( 'Method ' +  method + ' does not exist on jQuery.MyUInotice' );
        }
    }

    /**
     * Provides a widget container box.
     * Can be used as a modal dialog by specifying the option type:dialog;
     */
    var MyUIwidget = function() {

    this.defSettings = {};


    this._resetWidget = function($widget) {
        $widget.hide();
        $widget.empty();
        $widget.removeClass("widget-box widget-dialog");
        $("body .widget-dialog-overlay").remove();

    };
        this.settings = {type:"simple"};
        var thisObj = this;

        this.methods = {
            init : function(options){
                $this = $(this);

                thisObj.settings = $.extend({},thisObj.defSettings,options);
                
                $this.addClass("widget-box");

                var $header = $('<header/>');
                var $title  = $('<span class="widget-title"/>');
                $header.append($title);

                var $closeButton =$('<span class="widget-close"/>');
                
                var $contentBody = $('<div class="content-body"></div>');

                if (thisObj.settings.type == "dialog") {
                    $("body").append($('<div class="widget-dialog-overlay overlay"/>'));
                    $this.addClass("widget-dialog");
                    $("body").append($this);
                    $header.append($closeButton)
                }

                $this.append($header);
                $this.append($contentBody);

                $closeButton.click(function(){
                    thisObj._resetWidget($this);
                });
                
                return $this;
            },

            header : function(html) {

                var $header = $(this).children("header");
                if (html) {
                    $header.children(".widget-title").html(html);
                }
                else {
                    return $header;
                }
            },

            body : function(html) {
                var $body = $(this).children(".content-body");
                if (html) {
                    $body.html(html);
                }
                else {
                    return $body;
                }
            },

            close : function() {
                $(this).hide();
            },

            open : function() {
                $(this).show();
            },

            destroy : function() {
                thisObj._resetWidget($(this));
            }
        };
    };


    $.fn.MyUIwidget = function( method ) {
        var widgetObj = this.data("controller-class");

        if(!widgetObj) {
                widgetObj = new MyUIwidget();
                this.data("controller-class",widgetObj);

        }
            // Method calling logic
        if ( widgetObj.methods[method] ) {
          return widgetObj.methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
        } else if ( typeof method === 'object' || ! method ) {
          return widgetObj.methods.init.apply( this, arguments );
        } else {
          $.error( 'Method ' +  method + ' does not exist on jQuery.MyUIwidget' );
        }
    }


})(jQuery)

