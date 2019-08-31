# frozen_string_literal: true

# Base model
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def to_hateoas(rel_type = 'self')
  	url = "api_v1_#{self.class.name.downcase}_url"
  	{
  		rel: rel_type,
  		href: Rails.application.routes.url_helpers.send(url, id)
  	}.to_json
  end

  def to_json(options)
  	payload = JSON.parse(super(only: %i[id created_at]))
    payload['links'] = [JSON.parse(to_hateoas)] if id.present?
  	options.each { |attribute| payload[attribute.to_s] = self[attribute] }
  	payload
  end
end
