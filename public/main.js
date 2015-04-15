$(function() {
    $('.sidebar li > ul').each(function(i) {
        var $ul = $(this);
        var $a = $ul.siblings('a');
        var $parent = $ul.parent();
        $parent.addClass('folder');
        var $i = $('<i/>');
        $a.prepend($i);
        $i.on('click',function(e){
            e.preventDefault()
            $parent.toggleClass('open')
            $ul.toggleClass('open');
        });
    }).find('a').each(function(){
        var $a = $(this);
        if($a.hasClass('active')){
            $a.parents('li,ul').addClass('open');
            $a.siblings('ul').addClass('open');
            return false;
        }
    });

    $('table').tablesorter().addClass('sortable');

    $('pre code').each(function(i, block) {
        console.log(block)
        hljs.highlightBlock(block);
    });
});