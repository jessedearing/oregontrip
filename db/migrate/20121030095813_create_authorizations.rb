class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :token
      t.string :renew_token

      t.timestamps
    end
  end
end
