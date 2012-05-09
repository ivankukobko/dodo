module HelperMethods
  def sign_in email, password
    visit "/"
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    click_button I18n.t('login.link.login')
  end
end

RSpec.configure do |config|
  config.include HelperMethods
end

