module HelperMethods
  def sign_in email, password
    visit "/"
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
    click_button I18n.t('sessions.buttons.log_in')
  end
end

RSpec.configure do |config|
  config.include HelperMethods
end

