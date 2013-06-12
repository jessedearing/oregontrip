class CreateTableForLatitude < ActiveRecord::Migration
  def up
    create_table :latitudes do |t|
      t.string :lat
      t.string :lon
      t.datetime :expires_at
      t.timestamps
    end
  end

  def down
    drop_table :latitudes
  end
end
