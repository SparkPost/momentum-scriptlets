module("msys.dkimsign_config", package.seeall);

-- opendkim defaults
msys.dkimsign_config.defaults = {
  header_canon = "relaxed",
  body_canon = "relaxed",
  digest = "rsa-sha256",
  selector = "dkim-s1024",
  keyfile = "/opt/msys/ecelerity/etc/conf/default/dkim/%{d}/%{s}.key",
};

-- Domain specific overrides of the defaults
msys.dkimsign_config.domains = { 
  ["foo.com"] = {
    selector = "dkim-s2048",
  },
  ["esp.com"] = {
    selector = "esp_selector",
  },
  -- Additional DKIM signature with alternate signing domain
  ["__also_sign_domain__"] = {
    base_domain = "esp.com",
    selector = "esp_selector"
  }
};
