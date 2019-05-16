# frozen_string_literal: true

# A single event
class Event < ApplicationRecord

  include ActiveModel::Validations

  belongs_to :club

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :start_on, presence: true
  validates :end_on, presence: true

  validates_with StartOnValidator
  #validate  :start_on, :start_on_cannot_be_after_end_on #, :start_on_cannot_be_in_past

  private

  # Custom date validations
  def start_on_cannot_be_in_past
    errors.add(:start_on, 'must happen in the future') if Time.now >= @start_on
  end

  def start_on_cannot_be_after_end_on
    p "START: #{start_on}, END: #{end_on}"
    errors.add(:start_on, 'must be before the end') if @start_on >= @end_on
  end
end
