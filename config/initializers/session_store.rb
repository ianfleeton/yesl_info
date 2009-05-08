# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_yesl_info_session',
  :secret      => '6cc901d2a3f7c2ba6cbb894f3fdeea9a7b8179378f1bbbd5aa36b1d07b34b232ce157fc928bd0d345e353410df84808b5ddf2ccfa5d6128f2985772683599d0d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
