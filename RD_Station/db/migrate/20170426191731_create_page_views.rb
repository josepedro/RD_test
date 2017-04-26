class CreatePageViews < ActiveRecord::Migration[5.0]
  def change
    create_table :page_views do |t|
      t.string :page
      t.string :date
      t.string :time

      t.timestamps
    end
  end
end
