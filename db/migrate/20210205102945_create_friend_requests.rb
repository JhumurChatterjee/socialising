class CreateFriendRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|
      t.references :user,   foreign_key: true,                 null: false
      t.references :friend, foreign_key: { to_table: :users }, null: false
      t.datetime   :accepted_at
      t.datetime   :rejected_at

      t.timestamps
    end
  end
end
