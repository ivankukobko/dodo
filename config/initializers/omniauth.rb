Rails.application.config.middleware.use OmniAuth::Builder do

  require 'openid/store/filesystem'

  #  http://systemtruststart.com

  # Facebook
  provider :facebook, '270592589674726', '5b438f5f13387160693282b60be615c8'

  # Twitter
  #provider :twitter, 'vNumGaQHctfis3JQ2uq6Pw', 'YibIJjFoMyQVu6NXtOG63s42mE3LxwOELL7h8ecXTlE'

  # Vkontakte
  #provider :vkontakte_open_api, '2053689', '1e18V9vGihUL7qRPEi1f'
  #provider :vkontakte, '2053689', '1e18V9vGihUL7qRPEi1f'

  # Google
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp'), :name => 'openid'
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'

  # http://localhost/
  #provider :facebook, '175040925849843', '7189baf49eb4e2c43dfe853fd330be85'

end

