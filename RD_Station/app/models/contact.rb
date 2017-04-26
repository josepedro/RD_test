class Contact < ApplicationRecord
  has_many :page_views, dependent: :destroy
end
