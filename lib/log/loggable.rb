# frozen_string_literal: true

module Loggable
  def to_log_string(file_format:)
    raise NotImplementedError
  end
end
