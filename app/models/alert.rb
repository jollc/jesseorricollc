class Alert < ApplicationRecord
  validates :content, :start_date, :end_date, presence: true

  # Active Alerts
  # Active if start_date is today or earlier AND end_date is later than today.
  scope :active_alert, -> { where('start_date <= ?', Date.today) && where('end_date > ?', Date.today) }

end
