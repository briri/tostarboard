# frozen_string_literal: true

# Validations to ensure that the Registration Start is in the future,
# that the Start does not come after the End and that the End does not
# overlap the Start On date
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/AbcSize
# rubocop:disable Style/GuardClause
class RegistrationDateValidator < ActiveModel::Validator
  def validate(record)
    return if record.registration_start.nil?

    unless record.registration_start < record.registration_end
      record.errors[:registration_start] << 'cannot start before it ends'
    end
    return if record.start_on.nil?

    unless record.registration_end <= record.start_on
      record.errors[:registration_end] << 'must end before the event begins'
    end
  end
end
# rubocop:enable Style/GuardClause
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/AbcSize
