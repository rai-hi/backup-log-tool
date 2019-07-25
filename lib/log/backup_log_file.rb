# frozen_string_literal: true

class BackupLogFile
  attr_reader :backups

  def initialize(backups)
    @backups = backups
  end

  def backups_older_than_days(days)
    backups.select { |backup| backup.older_than_days?(days) }
  end
end
