{
  programs.floorp = {
    enable = true;

    profiles.default = {
      id = 0;

      search = {
        force = true;
        default = "STARTPAGE";
        privateDefault = "STARTPAGE";
        order = [
          "STARTPAGE"
          "Nixpkgs"
        ];
        engines = {
          STARTPAGE = {
            urls = [
              {
                template = "https://startpage.com/sp/search";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                  {
                    name = "prfe";
                    value = "f44ca064b90da6a2c3e4f4de82e5feb606f993ed4c1e45493a5319a377b88ab383bae8a739e576dd55afdf46d71c4e1df34e62e7f1625eb10b35ec0a04117f4f3cd337f3a30aaf023b9b02";
                  }
                ];
              }
            ];
          };
          Nixpkgs = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@np" ];
          };
          google.metaData.hidden = true;
          bing.metaData.hidden = true;
          ddg.metaData.hidden = true;
          st.metaData.hidden = true;
          yc.metaData.hidden = true;
        };
      };

      settings = {
        # arkenfox
        "browser.aboutConfig.showWarning" = false;
        "browser.startup.page" = 0;
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.newtabpage.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "geo.provider.ms-windows-location" = false;
        "geo.provider.use_corelocation" = false;
        "geo.provider.use_geoclue" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.shopping.experience2023.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "captivedetect.canonicalURL" = "";
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.search.suggest.enabled" = true;
        "browser.urlbar.suggest.searches" = true;
        "browser.urlbar.trending.featureGate" = false;
        "security.ssl.require_safe_negotiation" = true;
        "security.tls.enable_0rtt_data" = false;
        "security.OCSP.enabled" = 1;
        "security.OCSP.require" = true;
        "security.cert_pinning.enforcement_level" = 2;
        "security.remote_settings.crlite_filters.enabled" = true;
        "security.pki.crlite_mode" = 2;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode.upgrade_local" = true;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
        "media.peerconnection.ice.default_address_only" = true;
        "devtools.debugger.remote-enabled" = false;
        "permissions.manager.defaultsUrl" = "";
        "network.IDN_show_punycode" = true;
        "pdfjs.disabled" = false;
        "pdfjs.enableScripting" = false;
        "browser.contentanalysis.enabled" = false;
        "browser.contentanalysis.default_result" = 0;
        "extensions.postDownloadThirdPartyPrompt" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";

        # personal
        "browser.tabs.inTitlebar" = 1;
        "browser.tabs.loadInBackground" = false;
        "browser.taskbar.previews.enable" = true;
        "browser.theme.toolbar-theme" = 0;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "floorp.Tree-type.verticaltab.optimization" = true;
        "floorp.browser.sidebar.enable" = false;
        "floorp.browser.sidebar.is.displayed" = false;
        "floorp.browser.sidebar.right" = false;
        "floorp.browser.tabbar.settings" = 2;
        "floorp.chrome.theme.mode" = 1;
        "font.default.x-western" = "sans-serif";
        "font.name.monospace.x-western" = "Julia Mono";
        "font.name.sans-serif.x-western" = "SF Pro Display";
        "font.name.serif.x-western" = "New York Small";
        "ui.systemUsesDarkTheme" = 1;
        "userChrome.autohide.back_button" = true;
        "userChrome.autohide.forward_button" = true;
        "userChrome.autohide.navbar" = false;
        "userChrome.autohide.page_action" = true;
        "userChrome.autohide.sidebar" = false;
      };
    };
  };

  stylix.targets.floorp.profileNames = [ "default" ];
}
