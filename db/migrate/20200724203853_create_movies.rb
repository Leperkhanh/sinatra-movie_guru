class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year_released
      t.string :summary
      t.string :img
      t.string :trailer

      t.timestamps null: false
    end
  end
end
