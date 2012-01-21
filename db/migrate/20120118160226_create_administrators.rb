class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.references :user

      t.timestamps
    end
    add_index :administrators, :user_id
  end
end
