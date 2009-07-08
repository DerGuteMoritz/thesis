# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_thesis_session',
  :secret      => '89c30ad2bccde1e3d104a929d06b6139b9168a945ea24aa9ccbc9ac439549e9802d9207f39e7349ab4bd580a9bb03347d0746221cd7ed5e47aaca0ed6b79af60'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
