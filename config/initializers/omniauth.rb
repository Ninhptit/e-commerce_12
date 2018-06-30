Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT"], ENV["GOOGLE_SECRET"], image_size: 50

  provider :facebook, ENV["FACEBOOK_APP"], ENV["FACEBOOK_SECRET"], image_size: 50
  
end
