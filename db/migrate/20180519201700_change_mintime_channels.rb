class ChangeMintimeChannels < ActiveRecord::Migration[5.0]
  def change
    rename_column(:events, :timeMin, :time_min)
    rename_column(:events, :timeMax, :time_max)
  end
end
