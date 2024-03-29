'jQuery' in window && (function($) {
    function equalHeight(group) {
        tallest = 0;
        group.each(function() {
            thisHeight = $(this).height();
            if(thisHeight > tallest){
                tallest = thisHeight;
            }
        });
        group.height(tallest);
    }

    $(document).ready(function() {
        equalHeight($("div.left-container,div.right-container"));
    });
})(jQuery);
