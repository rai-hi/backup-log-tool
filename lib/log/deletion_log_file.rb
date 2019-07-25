# frozen_string_literal: true

class DeletionLogFile
  attr_reader :events

  def initialize(events)
    @events = events
  end

  def success_count(start_date, end_date)
    success_values(start_date, end_date).count(true)
  end

  def failure_count(start_date, end_date)
    success_values(start_date, end_date).count(false)
  end

  private

  def success_values(start_date, end_date)
    filter_to_date_range(start_date, end_date).map(&:successful?)
  end

  def filter_to_date_range(start_date, end_date)
    dates = [start_date, end_date]

    events.select do |event|
      event_date = event.backup_created_at
      event_date.between?(dates.min, dates.max)
    end
  end
end
