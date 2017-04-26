class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :email
      t.text :page_views
      t.string :client_id

      t.timestamps
    end
  end
end
