# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_TalleresEnLaCasa_session',
  :secret      => '6bda99a540f9c6e0507e95cb6c44cc681663c1a09f321441f10de2a40dc3fd06dc029a8d7d75d71bbff35268144cb891f607d5aa926d5cbfd5f2c61d09dceb35'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
