class AddUserIdComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.references :user
    end
  end

end
