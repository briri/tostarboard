# frozen_string_literal: true

# Validations to ensure that the Start On date is in the future
# and that the End On does not predate Start On
class StartOnValidator < ActiveModel::Validator

  def validate(record)
    return if record.start_on.nil?

    unless record.start_on >= Time.now
      record.errors[:start] << 'cannot start in the past'
    end
    return if record.end_on.nil?

    unless record.start_on < record.end_on
      record.errors[:start] << 'cannot start before it ends'
    end
  end

end