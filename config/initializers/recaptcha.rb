Recaptcha.configure do |config|
  config.skip_verify_env.push("development", "production")
end
