# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_team75_session',
  :secret      => '42c9cc32d4067b881c2a875cab43d7f4572ad8704203d5ed8cca6ea249f0b460594eee0785b8355cc6f9b4ecb84d0a325ee2d12a5a9281a29b77a3bf2149b62a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
