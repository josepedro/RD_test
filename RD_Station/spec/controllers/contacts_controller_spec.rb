require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the contacts" do
      contact1, contact2 = Contact.create!, Contact.create!
      get :index

      expect(assigns(:contacts)).to match_array([contact1, contact2])
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      Contact.destroy_all
      contact = Contact.create
      get :show, id: contact.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all of the pages views of contact" do
      Contact.destroy_all
      PageView.destroy_all
      contact = Contact.create
      page_view_1 = PageView.create
      page_view_2 = PageView.create
      contact.page_views << page_view_1
      contact.page_views << page_view_2
      get :show, id: contact.id

      expect(assigns(:contact).page_views).to match_array([page_view_1, page_view_2])
    end
  end

  describe "POST #create" do
    it "creates a new contact" do
      page_views = 'undefined@@/home@26/4/2017@20:17:31@@/
      price@26/4/2017@20:17:38@@/
      contact@26/4/2017@20:20:13@@/@27/4/
      2017@0:53:5@@/home@27/4/2017@0:53:11'
      client_id = '2642017202029168'
      email = 'jose@linux.com'
      contact_params = {:email => email, :client_id => client_id,
      :page_views => page_views}
      expect { post :create, :contact => contact_params}.to change(Contact, :count).by(1)
    end

    it "creates a new contact with correct email" do
      page_views = 'undefined@@/home@26/4/2017@20:17:31@@/
      price@26/4/2017@20:17:38@@/
      contact@26/4/2017@20:20:13@@/@27/4/
      2017@0:53:5@@/home@27/4/2017@0:53:11'
      client_id = '2642017202029168'
      email = 'jose@linux.com'
      contact_params = {:email => email, :client_id => client_id,
      :page_views => page_views}
      post :create, :contact => contact_params
      expect(assigns(:contact).email).to eq(email)
    end

    it "creates a new contact with correct client_id" do
      page_views = 'undefined@@/home@26/4/2017@20:17:31@@/
      price@26/4/2017@20:17:38@@/
      contact@26/4/2017@20:20:13@@/@27/4/
      2017@0:53:5@@/home@27/4/2017@0:53:11'
      client_id = '2642017202029168'
      email = 'jose@linux.com'
      contact_params = {:email => email, :client_id => client_id,
      :page_views => page_views}
      post :create, :contact => contact_params
      expect(assigns(:contact).client_id).to eq(client_id)
    end

    it "creates a new contact with correct page view name" do
      page_view = PageView.new(:page => '/home', :date => '26/4/2017',
      :time => '20:17:31')
      page_views = 'undefined@@/home@26/4/2017@20:17:31@@/
      price@26/4/2017@20:17:38@@/
      contact@26/4/2017@20:20:13@@/@27/4/
      2017@0:53:5@@/home@27/4/2017@0:53:11'
      client_id = '2642017202029168'
      email = 'jose@linux.com'
      contact_params = {:email => email, :client_id => client_id,
      :page_views => page_views}
      post :create, :contact => contact_params
      expect(assigns(:contact).page_views[0].page).to eq(page_view.page)
    end

    it "creates a new contact with correct page view date" do
      page_view = PageView.new(:page => '/home', :date => '26/4/2017',
      :time => '20:17:31')
      page_views = 'undefined@@/home@26/4/2017@20:17:31@@/
      price@26/4/2017@20:17:38@@/
      contact@26/4/2017@20:20:13@@/@27/4/
      2017@0:53:5@@/home@27/4/2017@0:53:11'
      client_id = '2642017202029168'
      email = 'jose@linux.com'
      contact_params = {:email => email, :client_id => client_id,
      :page_views => page_views}
      post :create, :contact => contact_params
      expect(assigns(:contact).page_views[0].date).to eq(page_view.date)
    end

    it "creates a new contact with correct page view time" do
      page_view = PageView.new(:page => '/home', :date => '26/4/2017',
      :time => '20:17:31')
      page_views = 'undefined@@/home@26/4/2017@20:17:31@@/
      price@26/4/2017@20:17:38@@/
      contact@26/4/2017@20:20:13@@/@27/4/
      2017@0:53:5@@/home@27/4/2017@0:53:11'
      client_id = '2642017202029168'
      email = 'jose@linux.com'
      contact_params = {:email => email, :client_id => client_id,
      :page_views => page_views}
      post :create, :contact => contact_params
      expect(assigns(:contact).page_views[0].time).to eq(page_view.time)
    end
  end

  describe "POST #update_outside" do
    it "returns a contact" do
      page_views = 'undefined@@/home@26/4/2017@20:17:31@@/
      price@26/4/2017@20:17:38@@/
      contact@26/4/2017@20:20:13@@/@27/4/
      2017@0:53:5@@/home@27/4/2017@0:53:11'
      client_id = '2642017202029168'
      email = 'jose@linux.com'
      contact_params = {:email => email, :client_id => client_id,
      :page_views => page_views}
      Contact.destroy_all
      PageView.destroy_all
      contact = Contact.create(:email => email, :client_id => client_id)
      post :update_outside, :contact => contact_params
      expect(assigns(:contact)).to eq(contact)
    end

    it "returns a contact with updated pages views" do
      page_view = PageView.new(:page => '/home', :date => '26/4/2017',
      :time => '20:17:31')
      page_views = 'undefined@@/home@26/4/2017@20:17:31@@/
      price@26/4/2017@20:17:38@@/
      contact@26/4/2017@20:20:13@@/@27/4/
      2017@0:53:5@@/home@27/4/2017@0:53:11'
      client_id = '2642017202029168'
      email = 'jose@linux.com'
      contact_params = {:email => email, :client_id => client_id,
      :page_views => page_views}
      Contact.destroy_all
      PageView.destroy_all
      contact = Contact.create(:email => email, :client_id => client_id)
      post :update_outside, :contact => contact_params
      expect(assigns(:contact).page_views[0].page).to eq(page_view.page)
    end
  end
end
