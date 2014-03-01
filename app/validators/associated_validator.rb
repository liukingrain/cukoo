class AssociatedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if Array.wrap(value).reject {|r| r.marked_for_destruction? || r.valid?}.any?
      record.errors.add(attribute, :invalid, options.merge(:value => value))
    end
  end
end
