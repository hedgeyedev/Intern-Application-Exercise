/* 
 * Polling object
 */


(function(){

    /**
     * @param interval : polling interval time
     * @param fun  : function to be executed at each interval
     */
    Poll = function(interval, fun){
        this.interval = interval;
        this.fun = fun;
        this.intervalID = null;
        this.arguments = Array.prototype.slice.call(arguments);;
    };

    Poll.prototype.startPolling = function() {
        this.intervalID = window.setInterval(this.fun, this.interval,this.arguments.slice(2));
    };

    Poll.prototype.stopPolling = function() {
        clearInterval(this.intervalID);
    };

    Poll.prototype.resetPolling = function(newInterval) {
        if (newInterval) {
            this.interval = newInterval;
        }
        this.stopPolling();
        this.startPolling();
    };

})();