# frozen_string_literal: true

# A type of event
class Race < Event
  has_many :race_results, dependent: :destroy
end
