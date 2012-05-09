class User < ActiveRecord::Base

  has_many :todo_lists,  :conditions => [ 'project_id is null' ]
  has_many :todo_items,  :through => :todo_lists
  has_many :collaborators, :include => :project
  has_many :projects,    :through => :collaborators
  has_many :todo_items_in_projects, :through => :projects, :source => :todo_items
  has_many :todo_lists_in_projects, :through => :projects, :source => :todo_lists
  has_many :invitations, :conditions => [ 'accepted_at is null' ]
  has_many :assignees
  has_many :assigned_todo_items, :through => :assignees, :source => :todo_item
  has_many :comments
  has_many :worklogs
  has_one  :administrator
  has_many :authentications, :dependent => :destroy

  #has_many :shared_todo_items, :through => :projects
  # TODO: find out how to make it work with postgre
  #has_many :co_workers, :through => :projects, :source => :users, :uniq => true

  attr_accessor :password

  before_save :encrypt_password

  #validates_presence_of :name
  #validates_presence_of     :password, :password_confirmation, :on => :create
  validates_confirmation_of :password#, :on => :create
  #validates_presence_of   :email
  validates_uniqueness_of :email

  def to_s
    name
  end

  def self.create_from_hash!(hash)
    user = find_or_initialize_by_email(hash['info']['email'])
    user[:name] ||= hash['info']['name']
    user.save!
    user
    #create( :name => hash['info']['name'],
            #:email => hash['info']['email']
            #:nickname => hash['info']['nickname']
          #)
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.generate_password email
    Digest::SHA2.hexdigest("--#{email}--#{Time.now.to_s}--")[0..8]
  end

  def self.authenticate(email, password)
    if !password.blank? && (user = find_by_email(email))
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      end
    end
  end

  def name
    self[:name] || self[:email]
  end

  def administrator?
    !!administrator
  end

  #def invite_collaborator target_email, project
    #if target_user = User.find_by_email(target_email)
      #project.collaborators.create(:user => target_user, :invited_by => self.id, :role_id => Collaborator::PROJECT_ROLES.index('collaborator') )
    #end
  #end

  # Invite user to project by email.
  # If user is registered in system, just creating an :invitaion: object,
  # if not --- create user account and send invitation email
  # TODO: users in the future will be able to register with
  # social network account and might have an empty email.
  # Find a solution for this case.
  def invite_user_to_project target_email, project
    if target_user = User.find_by_email(target_email)
      project.invitations.create(:user => target_user, :invited_by => self.id)
    else
      target_user = User.new(:email => target_email, :password => User.generate_password(target_email))
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
    Version.where(:whodunnit => self.co_workers.collect{|c| c.id if c.id != self.id}).order('created_at DESC').limit(10)
  end

end
