# frozen_string_literal: true

# Validations to ensure that the Registration Start is in the future,
# that the Start does not come after the End and that the End does not
# overlap the Start On date
class RegistrationDateValidator < ActiveModel::Validator

  def validate(record)
    return if record.registration_start.nil?

    unless record.registration_start >= Time.now
      record.errors[:registration_start] << 'cannot start in the past'
    end
    return if record.registration_end.nil?

    unless record.registration_start < record.registration_end
      record.errors[:registration_start] << 'cannot start before it ends'
    end
    return if record.start_on.nil?

    unless record.registration_end <= record.start_on
      record.errors[:registration_end] << 'must end before the event begins'
    end
  end

end