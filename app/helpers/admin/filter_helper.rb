module Admin::FilterHelper
  def filters(&block)
    @filters = true
    content_tag :script, "content-type" => "text/html", class: "filters", data: { role: "filters-popover" }, &block
  end
  
  def filters?
    !!@filters
  end
  
  def search_active?(query)
    query.conditions.any?{ |c| "id".in?(c.attributes.map(&:name)) }
  end
  
  def filters_active?(query)
    query.conditions.reject{ |c| "id".in?(c.attributes.map(&:name)) }.any?
  end
  
  def filters_toggle_class(query)
    filters_active?(query) ? "btn-primary active" : ""
  end
end
