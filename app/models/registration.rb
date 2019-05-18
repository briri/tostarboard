# frozen_string_literal: true

# A type of event
class Registration < Event
  belongs_to :user
  belongs_to :series, optional: true
  belongs_to :event, optional: true

  validates :user, presence: true
  validates :series, presence: true, unless: :event
  validates :event, presence: true, unless: :series

  validates :invoice_id, uniqueness: { case_sensitive: true }
  validates :invoice_id, presence: true, if: :paid?
  validates :paid_on, presence: true, if: :paid?
end
