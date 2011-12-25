class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.references :user
      t.references :project
      t.integer :invited_by, :null => false
      t.datetime :accepted_at

      t.timestamps
    end
    add_index :invitations, :user_id
    add_index :invitations, :project_id
    add_index :invitations, :invited_by

    remove_column :collaborators, :invited_by
    remove_column :collaborators, :accepted_at
  end

  def self.down
    remove_index :invitations, :user_id
    remove_index :invitations, :project_id
    remove_index :invitations, :invited_by
    drop_table :invitations
  end
end
