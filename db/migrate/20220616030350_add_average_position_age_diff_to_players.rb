class AddAveragePositionAgeDiffToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :average_position_age_diff, :string
  end
end
