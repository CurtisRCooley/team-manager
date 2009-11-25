# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_team_captain_session',
  :secret      => 'f1437af0414edd9338979f1a74859aa3f3386114ea8264017dcdd954497d65baa661f11d9baddb6b034c117e09ec86af9c50cae44ea63b85a11db27404e22eb0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
