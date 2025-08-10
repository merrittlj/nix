{
  programs.firefox = {
      enable = true;
      policies = {
        DisableTelemetry = true;
	DisableFirefoxStudies = true;
	DontCheckDefaultBrowser = true;
	DisablePocket = true;
	NoDefaultBookmarks = true;
	FirefoxSuggest.SponseredSuggestions = false;
	FirefoxHome.SponseredTopSites = false;
      };
  };
}
