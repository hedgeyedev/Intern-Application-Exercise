OmniAuth.config.logger = Rails.logger

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

Rails.application.config.middleware.use OmniAuth::Builder do
	#provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
	provider :facebook, '631252696902903', 'c65231354c8612903ba4f2197a8fb215'
end
