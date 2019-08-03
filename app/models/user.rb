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

  def api_token=(value)
    value.blank? ? super(nil) : super(generate_api_token)
  end

  private

  def generate_api_token
    return api_token if api_token.present?
    return nil unless email.present?
    TokenService.generate_digest(email)
  end

end
