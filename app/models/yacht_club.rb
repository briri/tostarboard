# frozen_string_literal: true

# A type of Club
class YachtClub < Club
  # Append "Yacht Club" to the end of the name if it does not exist
  def name=(value)
    value = value.split(' ').map(&:humanize).join(' ').squish
    value += ' Yacht Club' unless value.ends_with?('Yacht Club')
    super(value)
  end
end
