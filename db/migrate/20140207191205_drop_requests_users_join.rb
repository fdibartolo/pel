class DropRequestsUsersJoin < ActiveRecord::Migration
  def change
    drop_table :requests_users
  end
end
