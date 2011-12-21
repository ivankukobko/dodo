class User < ActiveRecord::Base

  has_many :todo_lists
  has_many :collaborators
  has_many :projects, :through => :collaborators
  has_many :todo_items, :through => :todo_lists

  attr_accessor :password

  before_save :encrypt_password

  validates_presence_of     :password, :password_confirmation, :on => :create
  validates_confirmation_of :password, :on => :create
  validates_presence_of   :email
  validates_uniqueness_of :email

  def to_s
    name
  end

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

  def invite_collaborator target_email, project
    if target_user = User.find_by_email(target_email)
      project.collaborators.create(:user => target_user, :invited_by => self.id )
    end
  end

  def accepted_project? project
    collaborator = collaborators.find_by_project_id(project.id)
    collaborator.owner? || !collaborator.accepted_at.nil?
  end

end
