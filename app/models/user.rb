# frozen_string_literal: true

# A Racer, Skipper, Club Admin or Super Admin
class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  has_and_belongs_to_many :roles
  has_many :registrations, dependent: :destroy

  belongs_to :club, optional: true

  validates :accept_terms, acceptance: true

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

  def api_credentials!
    token = generate_api_token!
    secret = generate_api_secret!
    return {} if token.nil? || secret.nil?

    update(client_token: token, client_secret: secret)
    { client_token: token, client_secret: secret }
  end

  private

  def generate_api_token!
    return client_token if client_token.present?
    return nil unless email.present?

    client_token = TokenService.generate_secret
    update(client_token: client_token)
  end

  def generate_api_secret!
    return client_secret if client_secret.present?
    return nil unless email.present? && client_token.present?
    
    TokenService.generate_digest({ email: email, client_token: client_token })
  end

end
