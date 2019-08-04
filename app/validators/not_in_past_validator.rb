# frozen_string_literal: true

class NotInPastValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "can't be blank") if value.blank?
    record.errors.add attribute, (options[:message] || "can't be in the past") if value <= Time.zone.today
  end

end
