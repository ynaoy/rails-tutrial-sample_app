class AddNoticeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :follower_notice, :boolean, default: true
  end
end
