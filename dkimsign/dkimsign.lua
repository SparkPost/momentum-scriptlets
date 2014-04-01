require("msys.core");
require("msys.validate.opendkim");
require("msys.extended.message");
require("dkimsign_config");

local mod = {};

local function table_merge(defaults, specifics)
  local new_t = {};

  if !specifics then
    return defaults;
  end

  for k, v in pairs(defaults) do
    if specifics and !specifics[k] then
      new_t[k] = v;
    end;
  end;

  if specifics then
    for k, v in pairs(specifics) do
      new_t[k] = v;
    end;
  end;

  return new_t;
end;

function mod:core_final_validation(msg, ac, vctx)
  local sending_domain = msg:address_header("From", "domain");
  local options = table_merge(msys.dkimsign_config.defaults, msys.dkimsign_config.domains[sending_domain[1]]);

  -- Sign.  Note that if a key isn’t found, this will just silently fail
  msys.validate.opendkim.sign(msg, vctx, options);

  -- Check if we’ve got an also_sign_domain
  if msys.dkimsign_config.domains["__also_sign_domain__"] then
    options = table_merge(msys.dkimsign_config.defaults, msys.dkimsign_config.domains["__also_sign_domain__"]);

    msys.validate.opendkim.sign(msg, vctx, options);
  end;

  return msys.core.VALIDATE_CONT;
end;

msys.registerModule("dkimsign", mod);
