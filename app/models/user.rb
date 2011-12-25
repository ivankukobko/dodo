class User < ActiveRecord::Base

  has_many :todo_lists#, :conditions => [ 'project_id IS ?', nil]
  has_many :collaborators#, :conditions => [ 'collaborators.accepted_at is not null' ]
  has_many :invitations, :conditions => [ 'accepted_at is null' ]
  has_many :projects, :through => :collaborators
  has_many :todo_items, :through => :todo_lists
  #has_many :shared_todo_items, :through => :projects

  has_many :co_workers, :through => :projects, :source => :users, :uniq => true

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

  #def invite_collaborator target_email, project
    #if target_user = User.find_by_email(target_email)
      #project.collaborators.create(:user => target_user, :invited_by => self.id, :role_id => Collaborator::PROJECT_ROLES.index('collaborator') )
    #end
  #end

  def invite_user_to_project target_email, project
    if target_user = User.find_by_email(target_email)
      project.invitations.create(:user => target_user, :invited_by => self.id)
    end
  end

  def accepted_project? project
    collaborators.find_by_project_id(project.id)
  end

  def is_owner? project
    if collaborator = collaborators.find_by_project_id(project.id)
      collaborator.is_owner?
    else
      false
    end
  end

  def is_collaborator? project
    if collaborator = collaborators.find_by_project_id(project.id)
      collaborator.is_collaborator?
    else
      false
    end
  end

  def news

  end

end
