ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "dodo.co.ua",
  :user_name            => "admin@dodo.co.ua",
  :password             => "59k09k4jj3",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "dodo.co.ua"
