class GroupEvent < ApplicationRecord
  acts_as_paranoid
  validates_presence_of :name
  validates :start_date, date: { allow_blank: true }
  validates :end_date, date: { allow_blank: true }
  validate :conflicting_data
  with_options if: :published? do
    validates_presence_of :description, :location, :start_date
    validates :start_date, date: { before_or_equal_to: :end_date }
    validates :end_date, date: true
  end
  before_save :calculate_start_date, :calculate_end_date, :calculate_duration

  private

  def calculate_start_date
    if end_date.present? && duration.present? && (duration_changed? || end_date_changed?)
      self.start_date = end_date - duration.to_i.public_send(:days)
    end
  end

  def calculate_end_date
    if start_date.present? && duration.present? && (duration_changed? || start_date_changed?)
      self.end_date = start_date + duration.to_i.public_send(:days)
    end
  end

  def calculate_duration
    if start_date.present? && end_date.present? && (start_date_changed? || end_date_changed?)
      self.duration = (end_date - start_date) / 1.day
    end
  end

  def conflicting_data
    if duration_changed? && start_date_changed? && end_date_changed?
      errors.add(:conflicting_data, "can't update or set duration, start and end date at the same time")
    end
  end
end
