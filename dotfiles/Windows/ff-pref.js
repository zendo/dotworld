//
// https://github.com/yokoffing/Betterfox

/** BETTERFOX OVERRIDES ***/
// PREF: restore Top Sites on New Tab page
user_pref("browser.newtabpage.activity-stream.feeds.topsites", true);
// PREF: restore search engine suggestions
user_pref("browser.search.suggest.enabled", true);
// PREF: allow websites to ask you for your location
user_pref("permissions.default.geo", 0);
// PREF: allow websites to ask you to receive site notifications
// user_pref("permissions.default.desktop-notification", 0);


/** MY OVERRIDES ***/
user_pref("browser.tabs.closeTabByDblclick", true);
user_pref("browser.tabs.closeWindowWithLastTab", false); // Prevent closing Firefox when closing the last tab
user_pref("browser.tabs.selectOwnerOnClose", false); // Closing tab and return to the adjacent tab
user_pref("browser.tabs.loadBookmarksInBackground", true);
user_pref("browser.toolbars.bookmarks.visibility", "always");
// user_pref("browser.urlbar.openintab", true); // open in a new tab
// user_pref("browser.search.openintab", true); // open in a new tab
// user_pref("browser.tabs.loadBookmarksInTabs", true); // open in a new tab
user_pref("browser.aboutConfig.showWarning", false);

// https://github.com/yokoffing/Betterfox/wiki/Common-Overrides#font-improvement
// PREF: improve font rendering by using DirectWrite everywhere like Chrome [WINDOWS]
user_pref("gfx.font_rendering.cleartype_params.rendering_mode", 5);
user_pref("gfx.font_rendering.cleartype_params.cleartype_level", 100);
user_pref("gfx.font_rendering.cleartype_params.force_gdi_classic_for_families", "");
user_pref("gfx.font_rendering.directwrite.use_gdi_table_loading", false);
