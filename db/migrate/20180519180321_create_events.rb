class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :timeMin
      t.string :timeMax
      t.string :summary
      t.string :location

      t.timestamps
    end
  end
end
