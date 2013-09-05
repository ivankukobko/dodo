class User < ActiveRecord::Base

  has_many :todo_lists
  # has_many :todo_items
  has_many :tasks, class_name: 'TodoItem'
  has_many :collaborators, include: :project
  has_many :projects, through: :collaborators
  has_many :tasks_in_projects, class_name: 'TodoItem', through: :projects, source: :tasks

  has_many :todo_items, class_name: 'TodoItem', finder_sql: proc{
    "SELECT DISTINCT todo_items.* FROM todo_items
    WHERE (todo_items.user_id = #{id})
    UNION ALL
    SELECT DISTINCT todo_items.* FROM todo_items
    JOIN collaborators ON (collaborators.user_id = #{id})
    JOIN projects ON (projects.id = collaborators.project_id)
    WHERE todo_items.project_id = projects.id
    "
  }
  has_many :invitations, :conditions => [ 'accepted_at is null' ]
  has_many :assignees
  has_many :assigned_todo_items, :through => :assignees, :source => :todo_item
  has_many :comments
  has_many :worklogs
  has_one  :administrator
  has_many :authentications, :dependent => :destroy

  has_many :co_workers, :through => :projects, :source => :users, :uniq => true

  attr_accessor :password

  before_save :encrypt_password

  # XXX: if user registers through oauth, we don't have his email and password
  #validates_presence_of     :password, :password_confirmation, :on => :create
  validates_confirmation_of :password
  validates_uniqueness_of :email

  def to_s
    name
  end

  def self.create_from_hash!(hash)
    user = find_or_initialize_by_email(hash['info']['email'])
    user[:name] ||= hash['info']['name']
    user.save!
    user
  end

  # TODO: integrate devise instead of this auth solution
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
        user.last_sign_in_at = Time.now
        user.save
        user
      end
    end
  end

  def name
    self[:name].blank? ? self[:email].split('@')[0].capitalize : self[:name]
  end

  def administrator?
    !!administrator
  end

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
    collaborators.find_by_project_id(project.id).is_owner? || false
  end

  def is_collaborator? project
    collaborators.find_by_project_id(project.id).is_collaborator? || false
  end

  #def news
    #Version.where(:whodunnit => self.co_workers.collect{|c| c.id if c.id != self.id}).order('created_at DESC').limit(10)
  #end

end
