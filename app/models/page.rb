class Page < Simplec::Page

  has_many :permissions
  has_many :permissible_users,
    through: :permissions,
    source: :user

  validates :title,
    presence: true

  scope :accessible_by, ->(user) {
    user.admin? || user.sysadmin? ?
      all : joins(:permissible_users).where(users: {id: user.id})
  }

  # Filter for admin section
  scope :filter_subdomain, -> (subdomain_id) { where subdomain_id: subdomain_id }

end

Simplec.load_pages
