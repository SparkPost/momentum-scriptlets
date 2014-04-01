This small module will allow quick and easy configuration of a dual
DKIM signing policy. Here are the steps to install it:

1. Copy dkimsign.lua to /opt/msys/ecelerity/etc/conf/default/dkimsign.lua
2. Create /opt/msys/ecelerity/etc/conf/default/dkimsign_config.lua and edit
   the config based on dkimsign_config-example.lua
3. Edit ecelerity.conf

--- Add to ecelerity.conf ---

opendkim "feedbackid-sign" {
  # Include Feedback-ID to prevent spoofing
  headerlist = ("from" "to" "message-id" "date" "subject" "Content-Type" "Feedback-ID")
}

scriptlet "scriptlet" {
  script "dkimsign" {
    source = "dkimsign"
  }
}

----------------------------

4. Verify new policy code with a "config reload"
5. Check in configuration in manager repo
