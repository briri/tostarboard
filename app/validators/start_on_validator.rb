# frozen_string_literal: true

# Validations to ensure that the Start On date is in the future
# and that the End On does not predate Start On
# rubocop:disable Metrics/AbcSize
class StartOnValidator < ActiveModel::Validator
  def validate(record)
    return if record.start_on.nil?

    record.errors[:start] << 'cannot start in the past' unless record.start_on >= Time.now
    return if record.end_on.nil?

    record.errors[:start] << 'cannot start before it ends' unless record.start_on < record.end_on
  end
end
# rubocop:enable Metrics/AbcSize
