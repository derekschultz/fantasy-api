class RemoveMinMaxAgeFromPlayers < ActiveRecord::Migration[7.0]
  def change
    remove_column :players, :min_age, :string
    remove_column :players, :max_age, :string
  end
end
