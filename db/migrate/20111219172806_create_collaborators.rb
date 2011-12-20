class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.references :user
      t.references :project
      t.integer :role_id, :default => 0
      t.integer :invited_by
      t.integer :accepted_at

      t.timestamps
    end
    add_index :collaborators, :user_id
    add_index :collaborators, :invited_by
    add_index :collaborators, :project_id
  end
end
