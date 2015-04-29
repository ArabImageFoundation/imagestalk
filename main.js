var deps = [{jQuery:"//code.jquery.com/jquery-2.1.3.min.js"}];
head.load(deps,function(){})

head.ready("jQuery",function() {
	var $body = $('body');

	var loading = 1;
	var load = function(){loading++;}
	var unload = function(){
		loading--;
		if(loading<=0){$body.removeClass('loading');}
	}

	var isModeSet = function(str){
		return ((new RegExp(str,'gi')).test(window.location.search));
	}

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

	if($('table').length){
		load();
		head.load(__rootPath+'/jquery.tablesorter.min.js',function(){
			$('table').tablesorter().addClass('sortable');
			unload();
		})
	}

	var $preCode = $('pre code');
	if($preCode.length){
		load();
		head.load(['//cdnjs.cloudflare.com/ajax/libs/highlight.js/8.5/styles/default.min.css','//cdnjs.cloudflare.com/ajax/libs/highlight.js/8.5/highlight.min.js'],function(){
			$('pre code').each(function(i, block) {
				hljs.highlightBlock(block);
			});
			unload();
		});
	}

	var $reveal = $('.reveal');

	if(isModeSet('asPresentation') && $reveal.length){
		var revealPath = __rootPath+'/.vendor/reveal/';
		var files = [
			revealPath+'js/reveal.js'
		,	revealPath+"css/reveal.css"
		,	revealPath+(isModeSet('print-pdf') ? 'css/theme/beige.css':'css/theme/black.css')
		,	revealPath+(isModeSet('print-pdf') ? 'css/print/pdf.css' : 'css/print/paper.css')
		];
		load();
		head.load(files,function(){
			$body.addClass('has-reveal');
			$('.reveal section').each(function(){
				this.id = 'slide'+this.id.replace(/\//g,'-');
			});
			Reveal.initialize({
				controls: true
			,	progress: true
			,	history: true
			,	center: true
			,	transition: 'slide'
			,	dependencies: [
				/**/
					{ src: revealPath+'lib/js/classList.js', condition: function() { return !document.body.classList; } }
				,	{ src: revealPath+'plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } }
				,	{ src: revealPath+'plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } }
				,	{ src: revealPath+'plugin/highlight/highlight.js', async: true, condition: function() { return !!document.querySelector( 'pre code' ); }, callback: function() { hljs.initHighlightingOnLoad(); } }
				,	{ src: revealPath+'plugin/zoom-js/zoom.js', async: true }
				,	{ src: revealPath+'plugin/notes/notes.js', async: true }
				/**/
				]
			});

			unload();
		})
	}else{
		$body.addClass('no-reveal')
	}

	function getCreateTimeLineItemsFunction(data,meta){
		return function createTimeLineItems(){
			var $item = $(this);
			var start = $item.children('.date-start').html();
			var end = $item.children('.date-end').html();
			var $content = $item.children('.timeline-item-content');
			var $subItems = $content.children('.timeline-item');
			if($subItems.length){
				$subItems.each(getCreateTimeLineItemsFunction(data,meta)).remove();
			}
			var type = $item.data('type') || 'box';
			if(!meta[type]){meta[type] = 'odd';}
			meta[type] = (meta[type]=='odd') ? 'even' : 'odd';
			data.push({
				id:data.length
			,	content:$content.html()
			,	start:start
			,	end:end || null
			,	type:type
			,	className:meta[type]
			});
			$item.addClass('processed');
		}
	}	

	function getCalculateTimelineZoom($container){
		var previousRange = '';
		return function calculateTimelineZoom(evt){
			var a = new Date(evt.start);
			var b = new Date(evt.end);
			var seconds = Math.floor((b-a)/1000);
			var minutes = Math.floor(seconds/60);
			var hours = Math.floor(minutes/60);
			var days = Math.floor(hours/24);
			var weeks = Math.floor(days/7);
			var months = Math.floor(days/30);
			var years = Math.floor(months/12);
			var currentRange;
			if(years){currentRange = 'years years-'+years+' months months-12';}
			else if(months){currentRange = 'months months-'+months+' weeks weeks-4';}
			else if(weeks){currentRange = 'weeks weeks-'+weeks+' days days-7';}
			else if(days){currentRange = 'days days-'+days+' hours hours-24';}
			else if(hours){currentRange = 'hours hours-'+hours+' minutes minutes-60';}
			else if(minutes){currentRange = 'minutes minutes-'+minutes+' seconds seconds-60';}
			else{currentRange = 'seconds seconds-'+seconds;}
			$container.removeClass(previousRange).addClass(currentRange);
			previousRange = currentRange;
		}
	}

	var $timeline = $('.timeline');
	if($timeline.length){
		load();
		head.load(['//cdnjs.cloudflare.com/ajax/libs/vis/3.12.0/vis.min.css','//cdnjs.cloudflare.com/ajax/libs/vis/3.12.0/vis.js'],function(){		
			$timeline.each(function(){		
				var $elements = $(this).removeClass('timeline').addClass('timeline-data');
				if(!$elements.length){
					throw new error('no elements');
				}
				var $container = $('<div class="timeline">').insertBefore($elements);
				var data = [];
				var meta = {};
				$elements.hide().children().not('.processed').each(getCreateTimeLineItemsFunction(data,meta));
				var options;
				try{
					options = $elements.data('options');
				}catch(e){
					options = {error:e};
				}
				options = $.extend({},{
					selectable:false
				,	height:'250px'
				},options);
				if(isModeSet('print-pdf')){delete options.end;}
				var timeline = new vis.Timeline($container[0],data,options);
				var calculateTimelineZoom = getCalculateTimelineZoom($container);
				timeline.on('rangechanged',calculateTimelineZoom);
				calculateTimelineZoom(timeline.getWindow());
				return this;
			}).addClass('processed');
			unload();
		})
	}

	unload();
});