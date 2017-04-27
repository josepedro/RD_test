require 'rails_helper'

RSpec.describe Contact, type: :model do
  it 'contact has page view' do
    contact = Contact.create
    page_view = PageView.create
    contact.page_views << page_view
    expect(contact.page_views[0]).to eq(page_view)
  end

   it 'contact has many pages view' do
     contact = Contact.create
     page_view_1 = PageView.create
     page_view_2 = PageView.create
     contact.page_views << page_view_1
     contact.page_views << page_view_2
     expect(contact.page_views[0]).to eq(page_view_1)
     expect(contact.page_views[1]).to eq(page_view_2)
  end

  it 'page views can be destroyed by contact' do
    contact = Contact.create
    page_view = PageView.create
    contact.page_views << page_view
    contact.destroy
    expect(contact.page_views).to eq(contact.page_views.destroy_all)
  end
end
