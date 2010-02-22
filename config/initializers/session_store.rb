# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_team75_session',
  :secret      => '9bd0f39e643f80741ff61413804dd8c3c8950b3f1b5a2c9aa7997631a8ee7ecd7e1c5f5e8818d2e1c77da9589dbb87ce9c591ce4a0c11535edb418847638a0a2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
