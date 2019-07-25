# frozen_string_literal: true

class LogFileFormat
  attr_reader :ordered_headings, :delimeter

  def initialize(ordered_headings:, delimeter: default_delimeter)
    check_headings(ordered_headings)

    @ordered_headings = ordered_headings
                        .map(&:to_sym)
    @delimeter = delimeter
  end

  def header_line_string
    ordered_headings.join(delimeter)
  end

  private

  def default_delimeter
    /\s{2,}/ # 2 or more whitespace chars
  end

  def check_headings(headings)
    invalid = headings.nil? || headings.empty?
    raise StandardError, "Ordered headings can't be nil/empty" if invalid
  end
end
