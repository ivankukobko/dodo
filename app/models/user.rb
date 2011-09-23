class User < ActiveRecord::Base

  has_many :todo_lists

  attr_accessor :password

  before_save :encrypt_password

  validates_presence_of     :password, :password_confirmation, :on => :create
  validates_confirmation_of :password, :on => :create
  validates_presence_of   :email
  validates_uniqueness_of :email

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    end
  end

  def name
    self[:name] || self[:email]
  end

end
