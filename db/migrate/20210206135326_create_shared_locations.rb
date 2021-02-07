class CreateSharedLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.references :user,      null: false, foreign_key: true
      t.text       :address,   null: false
      t.float      :latitude,  null: false
      t.float      :longitude, null: false

      t.timestamps
    end

    create_table :shared_locations do |t|
      t.references :location, null: false, foreign_key: true
      t.references :user,     null: false, foreign_key: true

      t.timestamps
    end
  end
end
