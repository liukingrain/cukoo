Sklep::Application.configure do
  begin
    env_smtp = YAML.load_file("#{Rails.root}/config/smtp.yml")[Rails.env]
    ActionMailer::Base.smtp_settings = env_smtp.symbolize_keys if env_smtp
    ActionMailer::Base.default :from => ActionMailer::Base.smtp_settings[:user_name]
  rescue Exception => e
    raise e unless Rails.env == "development"
  end
end
