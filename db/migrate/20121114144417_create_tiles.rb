class CreateTiles < ActiveRecord::Migration
  def change
    create_table :tiles do |t|
      t.integer :board_id
      t.integer :advertisement_id
      t.decimal :cost
      t.integer :x_loc
      t.integer :y_loc

      t.timestamps
    end
  end
end
