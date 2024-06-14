# frozen_string_literal: true

class Row
  attr_reader :id

  def id=(id)
    @id = id
  end

  def []=(key, value)
    @data ||= {}
    @data[key] = value
  end

  def [](key)
    @data[key]
  end
end
