class User < ApplicationRecord
  has_secure_password

  has_many :permissions
  has_many :pages,
    through: :permissions

  validates :name,
    presence: true
  validates :email,
    presence: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  scope :ordered, ->{ order(email: :asc) }
  scope :regular, ->{ where.not(admin: true, sysadmin: true) }

  module Normalizers
    def email=(value)
      super value.to_s.strip.downcase
    end
  end
  prepend Normalizers

  class Unauthenticated < StandardError; end
  class Unauthorized < StandardError; end

end
