module ContactsHelper
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
