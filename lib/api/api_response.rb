# frozen_string_literal: true

class ApiResponse
  attr_reader :code, :body

  def initialize(code:, body:)
    @code = code
    @body = body
  end

  def failure?
    @code != 200
  end
end
