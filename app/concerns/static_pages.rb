module StaticPages
  extend ActiveSupport::Concern
  
  included do
    before_filter :load_pages, unless: :format_json?
    helper_method :special_page_path
  end
  
  def special_page_path(page, options = {})
    special_page_url(page, options.merge(only_path: true))
  end
  
  private
  
  def load_pages
    @footer_pages = policy_scope(Page.ordered.by_menu("footer"))
    @header_pages = policy_scope(Page.ordered.by_menu("header"))
    @shortcut_pages = policy_scope(Page.ordered.by_menu("shortcuts"))
    @layout_page = Page.find_by(name: "root")
  end
  
  def special_page_url(page, options = {})
    if page.special?
      send("#{page.name}_url", options)
    else
      friendly_page_path(page.slug, options)
    end
  end
  
  def format_json?
    request.format.json?
  end
  
  def set_controller_page(name = controller_name)
    @page = Page.find_by(name: name)
  end
end
