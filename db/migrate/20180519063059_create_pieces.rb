class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.string :mood
      t.string :type
      t.string :source
      t.string :title
      t.string :creator

      t.timestamps
    end
  end
end
