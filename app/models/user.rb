# frozen_string_literal: true

# A Racer, Club Admin or Super Admin
class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable, :lockable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  # Doorkeeper associations
  has_many :oauth_applications, class_name: "Doorkeeper::Application", as: :owner

  has_many :access_grants, class_name: "Doorkeeper::AccessGrant",
           foreign_key: :resource_owner_id, dependent: :delete_all

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
           foreign_key: :resource_owner_id, dependent: :delete_all

  # Associations
  belongs_to :club, optional: true
  has_and_belongs_to_many :roles
  has_many :users_vessels
  has_many :vessels, through: :users_vessels
  has_many :registrations, dependent: :destroy
  
  # Validations
  validates :accept_terms, acceptance: true

  after_create :generate_api_token!

  def name
    return email if first_name.nil? && last_name.nil?

    [first_name, last_name].join(' ')&.squish
  end

  def first_name=(value)
    super(value&.humanize)
  end

  def last_name=(value)
    super(value&.humanize)
  end

  # JSON for API
  def to_json(options = {})
    payload = JSON.parse(super(only: %i[id first_name last_name email]))
    payload[:club] = JSON.parse(club.to_hateoas('member_of')) if club.present?
    payload[:vessels] = vessels.map { |v| JSON.parse(v.to_hateoas('sails_aboard')) }
    payload[:links] = to_hateoas if id.present?
    payload.to_json
  end

  private

  def generate_api_token!
    return false unless email.present?
    payload = { 
      user_id: id, 
      email: email, 
      username: name, 
      secret: TokenService.generate_uuid 
    }
    update(secret: TokenService.encode(payload.to_json))
  end

end
