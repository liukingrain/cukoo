module Admin::SimpleFormHelper
  def simple_form_for(record, options={}, &block)
    if controller.class.name.split("::").first == "Admin"
      options[:wrapper] ||= :bootstrap
      options[:html] ||= { }
      options[:html][:class] = options[:wrapper] == :search ? "form-inline" : "form-horizontal"
    end
    super(record, options, &block)
  end
end
