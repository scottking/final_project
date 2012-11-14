class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.integer :user_id
      t.integer :board_id
      t.integer :height
      t.integer :width
      t.binary :image
      t.integer :x_loc
      t.integer :y_loc

      t.timestamps
    end
  end
end
