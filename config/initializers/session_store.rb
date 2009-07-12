# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_thesis_session',
  :secret      => '0a4eb62a223addce75f4a3c390a90004a18853e1d8004ef2b770e73fe2b08bf4c53cd65dfb70d346a7b060e5e63f530f4ed2be440bd9992e7172cdd9636f389f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
