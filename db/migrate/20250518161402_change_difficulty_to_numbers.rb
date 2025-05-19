class ChangeDifficultyToNumbers < ActiveRecord::Migration[7.1]
  def change
    remove_column :questions, :difficulty, :string

    add_column :questions, :difficulty, :integer
  end
end
