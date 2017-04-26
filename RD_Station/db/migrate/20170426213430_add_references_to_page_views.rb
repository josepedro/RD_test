class AddReferencesToPageViews < ActiveRecord::Migration[5.0]
  def change
    add_reference :page_views, :contact, foreign_key: true
  end
end
