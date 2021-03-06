class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @page_views_array = @contact.page_views.sort_by{|u| u.time}
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(email: contact_params[:email],
      client_id: contact_params[:client_id])
    pages_views_array = get_page_views_parsed(contact_params[:page_views])
    pages_views_array.each do |page_view|
      @contact.page_views << PageView.new(page: page_view[0],
      date: page_view[1], time: page_view[2])
    end

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.page_views.destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_outside
    client_id = contact_params[:client_id]
    if Contact.exists?(client_id: client_id)
      @contact = Contact.find_by(client_id: client_id)
      @contact.page_views.destroy_all
      pages_views_array = get_page_views_parsed(contact_params[:page_views])
      pages_views_array.each do |page_view|
        @contact.page_views << PageView.new(page: page_view[0],
        date: page_view[1], time: page_view[2])
      end
      if @contact.save
        return render nothing: true, status: :ok
      else
        return render nothing: true, status: :unprocessable_entity
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:email, :page_views, :client_id)
    end

    def get_page_views_parsed(string_pages_view)
      string_pages_view.slice! "undefined@@"
      array_pages_view_date_hour = string_pages_view.split("@@")
      pages_view_date_hour_splited = []
      array_pages_view_date_hour.each do |page_view|
        pages_view_date_hour_splited << page_view.split("@")
      end
      return pages_view_date_hour_splited
    end
end
