class AddDateDayToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :date_day, :date
  end
end
