/********************************************************************************************
File:           main.js
Version:        6.0.1
Last Modified:  Sep-10-2009
---------------------------------------------------------------------------------------------
Description:    Javascript functions for the University of British Columbia's web sites.
---------------------------------------------------------------------------------------------
Notes:          Main Javascript functions mega menus, spotlight rotation and widgets.
---------------------------------------------------------------------------------------------
Version Notes:
- v.6.0:        Official JS scripts released with Template 6.0.

- v.6.0.1:		Bug fix release

				a. Decoupled MegaMenus expansion from 'a place of mind' expansion
				b. MegaMenu Trigger Redirection - activates if MegaMenu content doesn't load 
					after 1.5 seconds.

---------------------------------------------------------------------------------------------
Contact:        UBC Public Affairs
                t: 604.822.2130
                e: web.admin@ubc.ca
                w: www.webcommunications.ubc.ca

********************************************************************************************/

(function($) {
    
	//Load Google feed js
	google.load("feeds", "1");
		
	$(document).ready(function() 
    {
    	if(UbcMegaMenu) { // See Config Settings in config.js
			Ubc.megaMenu.init();
		}
		
		if(UbcMainMenuDropDown) {
    		Ubc.mainMenu.init();
		}
		
    	Ubc.search.init();
    	Ubc.homeQuickLinks.init();
    	Ubc.homeHeadlineWidget.init();
		
		if(UbcPlaceOfMind && UbcMegaMenu) { // See Config Settings in config.js
    		Ubc.placeOfMind.init();
		}
		
		Ubc.UbcSecondNav.init(); // WordPress Package Only
    });

    var Ubc = window.Ubc || {};
    
    Ubc.megaMenu = {
        currentMegaMenu: null,
        links: null,
        isAnimating: false,
		

        init: function() 
        {
			if(UbcPlaceOfMind) { // See Config Settings in config.js
				Ubc.megaMenu.links = $('#UbcCampusLinks, #UbcDirectLinks, #UbcQuickLinks, #UbcMindLink').click(Ubc.megaMenu.onMegaClick);
			} else {
				Ubc.megaMenu.links = $('#UbcCampusLinks, #UbcDirectLinks, #UbcQuickLinks').click(Ubc.megaMenu.onMegaClick);
			}
			
            $('#UbcMegaMenues a.UbcCloseBtn').click(Ubc.megaMenu.onCloseBtnClick);
        },

        onMegaClick: function(event) 
        {
            event.preventDefault();
			
			var anchor = $(this);
            var id = anchor.attr('id');
			
			if($('.UbcCampusLinks').length<1 && id!='UbcMindLink') { // If Megamenu hasn't been remotely loaded yet.				
				$.getJSON(
					"http://da.ubc.ca/visualidentity/clf/header/globalutility.php?jsoncallback=?", 
					function(data, textStatus) {
						$('#UbcMegaMenues a.UbcCloseBtn').before(data.html); // Load it, and then place it in the div
					}
				);
				
				// Set Timer to trigger link directly to landing page if globalutility doesn't load in 1.5 seconds
				landingPageURL = $('#'+id).attr("href");
				var goToLandingPage = setTimeout('window.location = landingPageURL', 1500);

				// Set callback to trigger the "click" action on the link when AJAX is done getting the MegaMenu
				$(this).ajaxStop(function(){
					$(this).click();
					$(this).unbind('ajaxStop');
					clearTimeout ( goToLandingPage );
				});

				return; // prevents the animation part of the script from running. Re-trigger the action through the ajaxStop binding above.
			}

            if (Ubc.megaMenu.isAnimating) return;

            if (Ubc.megaMenu.currentMegaMenu && anchor.attr('id') != Ubc.megaMenu.currentMegaMenu) 
            {
                $('#UbcMegaMenues ul.' + Ubc.megaMenu.currentMegaMenu).hide();
                Ubc.megaMenu.links.removeClass('UbcSelected').trigger('closed');
                Ubc.megaMenu.currentMegaMenu = null;
            }

            var megaMenuSelector = '#UbcMegaMenues ul.' + id;

            Ubc.megaMenu.isAnimating = true;

            if (anchor.hasClass('UbcSelected')) 
            {
                //hide menu
                $(megaMenuSelector).slideUp(400, function() { $('#UbcMegaMenues').slideUp(200, Ubc.megaMenu.onAnimationFinish); });

                anchor.removeClass('UbcSelected').trigger('closed');
                Ubc.megaMenu.currentMegaMenu = null;
            }
            else 
            { //show menu
                $(megaMenuSelector).show();
                $('#UbcMegaMenues').slideDown(400, Ubc.megaMenu.onAnimationFinish);
                anchor.addClass('UbcSelected').trigger('opened');
                Ubc.megaMenu.currentMegaMenu = id;
            }
        },

        onCloseBtnClick: function(event) 
        {
            event.preventDefault();

            if (Ubc.megaMenu.isAnimating) return;

            Ubc.megaMenu.isAnimating = true;

            $('#UbcMegaMenues').slideUp(400, function() 
            {
                $('#UbcMegaMenues ul.' + Ubc.megaMenu.currentMegaMenu).hide();
                Ubc.megaMenu.onAnimationFinish();
            });
            Ubc.megaMenu.links.removeClass('UbcSelected').trigger('closed');
        },

        onAnimationFinish: function() 
        {
        	Ubc.megaMenu.isAnimating = false;
        }
    };

    Ubc.mainMenu = {
        selectedTop: null,
        openMenu: null,
        timer: null,
        target: null,

        init: function() 
        {
            var anchors = $('#UbcMainNav > li');
            anchors.mouseenter(Ubc.mainMenu.setTimer);
            anchors.mouseleave(Ubc.mainMenu.setTimer);
			
			if($('#UbcMainNav').hasClass('UbcProcessMenu')) {
				Ubc.mainMenu.splitLinks(anchors);
			}

            $('#UbcMainNav').append('<li class="UbcSelectedTop"> </li>');
            Ubc.mainMenu.selectedTop = $('#UbcMainNav li.UbcSelectedTop');

            $(document).click(Ubc.mainMenu.onMenuOut);
        },

		splitLinks: function(anchors) {
			
			anchors.each(function (i) {
				submenu = $(this).find("ul");
				submenu.addClass("UbcSubMenu");
				if($(submenu).find("li.UbcSubMenuSection").length<=0) {
					if(submenu.find("li").length>0) {
						var subMenuItems = submenu.find("li");
						
						var subSectionsNum = Math.ceil(subMenuItems.length/3);
						var subSections = new Array();
						
						for(var i=0; i<subSectionsNum; i++) {
							subSections[i] = $('<li class="UbcSubMenuSection"><ul></ul></li>');
						}
						
						subMenuItems.each(function(i) {
							subSections[Math.floor(i/3)].find('ul').append(this);
						});
						
						submenu.empty();
						
						for(var i=0; i<subSections.length; i++) {
							submenu.append(subSections[i]);
						}
					}
				}
			});
		},

        setTimer: function(event) 
        {
            if (Ubc.mainMenu.timer)
                window.clearTimeout(Ubc.mainMenu.timer);

            Ubc.mainMenu.target = this;
            if (event.type == 'mouseenter')
            	Ubc.mainMenu.timer = window.setTimeout(Ubc.mainMenu.onMenuEnter, 300);
            else if (event.type == 'mouseleave')
            	Ubc.mainMenu.timer = window.setTimeout(Ubc.mainMenu.onMenuOut, 300);
        },

        onMenuEnter: function() 
        {			
			Ubc.mainMenu.timer = null;

        	Ubc.mainMenu.onMenuOut();

            var li = $(Ubc.mainMenu.target);

            var pos = li.position();
            var submenu = li.children('ul.UbcSubMenu');

            if (submenu.length == 0)
                return;

            Ubc.mainMenu.openMenu = submenu;

            var bgXPos = pos.left + parseInt(li.width() / 2) - 6;

            Ubc.mainMenu.selectedTop.css({ 'left': bgXPos.toString() + 'px', 'display': 'block' });
            submenu.show();
        },

        onMenuOut: function() 
        {
        	Ubc.mainMenu.timer = null;
            if (Ubc.mainMenu.openMenu) 
            {
            	Ubc.mainMenu.openMenu.hide();
            	Ubc.mainMenu.selectedTop.hide();
            }
        }
    };
    
    Ubc.search = {
    	init: function() 
    	{
    		$('#UbcSearchForm input.UbcSearchBtn').hover(
    			function()
    			{
    				$(this).css('background-position', '0 0')
    			},
    			function()
    			{
    				$(this).css('background-position', '0 -22px');
    			}
    		);
			
			var refine = false;
			
			if(typeof SubUnitLabel=="string") {
				if(SubUnitLabel!='') {
					$('#UbcSearchForm').append('<input type="hidden" name="label" value="'+SubUnitLabel+'" />');
					refine = true;
				}
				
			}
			
			if(typeof SearchSite=="string") {
				if(SearchSite!='') {
					if(typeof SubUnitLabel=="string") {
						if(SubUnitLabel=='') { $('#UbcSearchForm').append('<input type="hidden" name="label" value="'+SearchSite+'" />'); }
					} else {
						$('#UbcSearchForm').append('<input type="hidden" name="label" value="'+SearchSite+'" />');
					}
					
					$('#UbcSearchForm').append('<input type="hidden" name="site" value="'+SearchSite+'" />');
					refine = true;
				}
			}
			
			if(refine) { $('#UbcSearchForm').attr('action','http://www.ubc.ca/search/refine/');
			}
    	}
    };

    Ubc.homeQuickLinks = {
        init: function() 
        {
            var items = $('#UbcContentSidebar div.UbcQuickLinks ul.UbcLinksBar li a').click(Ubc.homeQuickLinks.onClick);

            var selected = $('#UbcContentSidebar div.UbcQuickLinks ul.UbcLinksBar li.UbcSelected a').click();

            if (selected.length == 0) 
            {
                $(items.get(0)).parent('li').addClass('UbcSelected');
                $(items.get(0)).click();
            }
        },

        onClick: function(event) {
            var lis = $('#UbcContentSidebar div.UbcQuickLinks ul.UbcLinksBar li').removeClass('UbcSelected');

            $(this).parent('li').addClass('UbcSelected');

            var count = 0;
            lis.each(function(i) 
            {
                if ($(this).hasClass('UbcSelected')) 
                {
                    count = i;
                    return false;
                }
            });

            var sections = $('#UbcContentSidebar div.UbcQuickLinks ul.UbcLinksSection').hide();

            if (sections.length >= count)
                $(sections.get(count)).show();

            event.preventDefault();
        }
    };

    Ubc.homeHeadlineWidget = {
        listing: null,

        init: function() 
        {
    		Ubc.homeHeadlineWidget.listing = $('#UBCHeadlineWidget ul.UBCStoriesListing');

            if (Ubc.homeHeadlineWidget.listing.length == 0) return;

            var listingLength = Ubc.homeHeadlineWidget.listing.children('li').length;
            $('#UBCHeadlineWidget div.UbcHeadlineNav span').text('1 / ' + listingLength.toString());

            Ubc.homeHeadlineWidget.listing.cycle({
                fx: 'fade',
                timeout: 5000,
                speed: 600,
                next: '#UBCHeadlineWidget div.UbcHeadlineNav a.UbcHeadlineNavNext',
                prev: '#UBCHeadlineWidget div.UbcHeadlineNav a.UbcHeadlineNavPrev',
                after: Ubc.homeHeadlineWidget.onStoryTransition
            });

            $('#UBCHeadlineWidget div.UbcHeadlineNav a.UbcHeadlineNavPause').click(Ubc.homeHeadlineWidget.onPause);
        },

        onPause: function(event) 
        {
            var btn = $(this);

            if (btn.hasClass('UbcHeadlineNavPause')) 
            {
                btn.removeClass('UbcHeadlineNavPause');
                btn.addClass('UbcHeadlineNavPlay');
                Ubc.homeHeadlineWidget.listing.cycle('pause');
            }
            else 
            {
            	btn.removeClass('UbcHeadlineNavPlay');
            	btn.addClass('UbcHeadlineNavPause');
            	Ubc.homeHeadlineWidget.listing.cycle('resume');
            }

            event.preventDefault();
        },

        onStoryTransition: function(currSlideElement, nextSlideElement, options, forwardFlag) 
        {
            $('#UBCHeadlineWidget div.UbcHeadlineNav span').text((options.currSlide + 1).toString() + ' / ' + Ubc.homeHeadlineWidget.listing.children('li').length.toString());
        }
    };

    Ubc.placeOfMind = {
        state: true,
        loaded: false,
        month: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        init: function() 
        {
		    var pomEle = $('<ul class="UbcMegaMenu UbcCol4 UbcMindLink UbcClear"></ul>');
		    pomEle.append('<li class="UbcPMCallout"><h2>A place of mind; UBC is tackling the world\'s big problems. With you.</h2><a href="http://www.aplaceofmind.ubc.ca/'+UbcPlaceOfMindLink+'">Learn more</a></li>');
		    pomEle.append('<li class="UbcLoading"><img style="padding: 50px 100px;" src="/_ubc_clf/img/header/circularLoading.gif" alt="loading" /></li>');
    		
		    $('#UbcMegaMenues').prepend(pomEle);
    		
			$('a#UbcMindLink').css('background-image', 'url(/_ubc_clf/img/header/PlaceOfMind-Gif-V04-off.gif)');
			
		    $('a#UbcMindLink').mouseenter(function() 
            {
                if (Ubc.placeOfMind.state) 
                {
                    $(this).css('background-image', 'url(/_ubc_clf/img/header/PlaceOfMind-Gif-V04-on.gif)');
                    Ubc.placeOfMind.state = false;
                }
                else 
                {
                    $(this).css('background-image', 'url(/_ubc_clf/img/header/PlaceOfMind-Gif-V04-off.gif)');
                    Ubc.placeOfMind.state = true;
                }
            });

            $('a#UbcMindLink')
                .bind('opened', function(event) 
                {
                    $(this).parent('li.UbcMindLink').css('background-position', '0 -98px');
                    
                    //Change BG
                    $('#UbcMegaMenuesWrapper, #UbcMegaMenues').addClass('UbcMindLink');
                    
                    if (!Ubc.placeOfMind.loaded)
                    	Ubc.placeOfMind.loadRss();
                })
                .bind('closed', function(event) 
                {
                    $(this).parent('li.UbcMindLink').css('background-position', '0 0');
                    $('#UbcMegaMenuesWrapper, #UbcMegaMenues').removeClass('UbcMindLink');
                });
        },
        
        loadRss: function()
        {
        	//var feed = new google.feeds.Feed("http://feeds.gawker.com/gizmodo/excerpts.xml"); // fjord's original
			var feed = new google.feeds.Feed(UbcPlaceOfMindRSS); // See Config Settings in config.js
			
        	feed.setNumEntries(3);
        	
        	feed.load(function(result)
        	{
        		if (result.error)
        		{
        			$('#UbcMegaMenues ul.UbcMindLink li.UbcLoading').html('<p>' + result.error.message + '</p>');
        			return;
        		}
        		
        		Ubc.placeOfMind.loaded = true;
        		
        		$('#UbcMegaMenues ul.UbcMindLink li.UbcLoading').remove();
        		var megaUl = $('#UbcMegaMenues ul.UbcMindLink');
        		
        		for (var i = 0; i < result.feed.entries.length; i++) 
        		{
        			var entry = result.feed.entries[i];
        			var h3 = '<h3><a href="' + entry.link + '" target="_blank">' + entry.title + '</a></h3>';
        			var pubDate = new Date(entry.publishedDate);
        			var date = '<p class="UbcDate">Submitted: ' + Ubc.placeOfMind.month[pubDate.getMonth()] + ' ' + pubDate.getDate().toString() + ', ' + pubDate.getFullYear().toString() + '</p>';
        			var desc = '<p>' + entry.content + '</p>';
        			var more = '<a href="' + entry.link + '" target="_blank" class="UbcMore">More \u00BB</a>';
        			var li = $('<li class="UbcMenuSection">' + h3 + date + desc + more + '</li>');
        			
        			megaUl.append(li);
        		}
        		
        		var colHeight = 0;
        		
        		megaUl.children().each(function(index)
        		{
        			var height = $(this).height();
        			
        			if (height > colHeight)
        				colHeight = height;
        		});
        		
        		//Apply height so all the borders are even
        		megaUl.children().each(function(index)
        		{
        			var ele = $(this);
        			
        			if (ele.hasClass('UbcPMCallout')) return;
        			
        			ele.css('height', colHeight.toString() + 'px');
        		});
        	});
        }
    };
	
	Ubc.UbcSecondNav = { // WordPress only Navigation Fix. Adds 'UbcLast' to every li that's last in its set.
		init: function() 
		{
			// Hide secondary level navigation unless page is current
			if($('#UbcSecondNav').hasClass("UbcSecondNavCollapse")) {
				
				$('#UbcSecondNav li.page_item > ul').hide();
				
				$('#UbcSecondNav li.current_page_item > ul, #UbcSecondNav li.current_page_ancestor > ul').show()
				
			}
			
			// Add 'UbcLast' class to eliminate double closing bottom borders
			$('#UbcSecondNav').find('ul').each(function () {
				$(this).find('li:last').addClass('UbcLast');										 
			});
		}
	};
})(jQuery);