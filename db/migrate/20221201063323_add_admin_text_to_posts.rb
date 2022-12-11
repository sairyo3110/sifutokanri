class AddAdminTextToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :admin_text, :text
  end
end
