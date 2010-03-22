/********************************************************************************************
File:           config.js
Version:        6.0
Last Modified:  Aug-25-2009
---------------------------------------------------------------------------------------------
Description:    Javascript functions for the University of British Columbia's web sites.
---------------------------------------------------------------------------------------------
Notes:          Configurable settings for Javascript functions.
---------------------------------------------------------------------------------------------
Version Notes:
- v.6.0:        Official JS scripts released with Template 6.0.
---------------------------------------------------------------------------------------------
Contact:        UBC Public Affairs
                t: 604.822.2130
                e: web.admin@ubc.ca
                w: www.webcommunications.ubc.ca

********************************************************************************************/

// Turns MegaMenu on or off - See $(document).ready() in main.js
var UbcMegaMenu = true;

// Turns Place of Mind Effect on or off - See $(document).ready() & Ubc.megaMenu.init() in main.js
var UbcPlaceOfMind = false;

// Appends URL string after http://www.aplaceofmind.ubc.ca/ in the Learn More button in the Place of Mind MegaMenu. 
// Use an emptry string - i.e. "" - for the link to go directly to http://www.aplaceofmind.ubc.ca/
var UbcPlaceOfMindLink = "";

// Sets the RSS feed address for the A Place of Mind effect -  See method Ubc.placeOfMind.loadRss() in main.js
var UbcPlaceOfMindRSS = "http://www.aplaceofmind.ubc.ca/feed/?cat=-1";

// Turns MainMenu drop-downs on or off - See $(document).ready() & Ubc.megaMenu.init() in main.js
var UbcMainMenuDropDown = true;

// Set Search Label - If in doubt, use your unit's name.  i.e. Human Resources, Arts, President's Office, etc.
// See Ubc.search.init() in main.js
var SubUnitLabel = "";

// Set Search Domain - Specify the domain for search results.  If in doubt, use *.yourdomain.ubc.ca - i.e. *.hr.ubc.ca, *.arts.ubc.ca, *.president.ubc.ca
// See Ubc.search.init() in main.js
var SearchSite = "";