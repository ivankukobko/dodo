class Authentication < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  # authentication with oauth
  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'].to_s )
  end

  # authentication and creating user account
  def self.create_from_hash(hash, user = nil)
    user ||= User.create_from_hash!(hash)
    Authentication.create(:user => user, :uid => hash['uid'], :provider => hash['provider'])
  end
end
