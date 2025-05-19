class ChangeOptionsToJsonInQuestions < ActiveRecord::Migration[7.1]
  def change

    remove_column :questions, :option_1, :string
    remove_column :questions, :option_2, :string
    remove_column :questions, :option_3, :string
    remove_column :questions, :option_4, :string

    add_column :questions, :options, :jsonb, default: {}, null: false

  end
end
