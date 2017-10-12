OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '684139444078-t5pbe0kf4m3abco02b5piflalr01rpqp.apps.googleusercontent.com',
           '14UjXKM_3_pT8UgLeR0KcBCy', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end