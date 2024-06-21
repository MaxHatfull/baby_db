# frozen_string_literal: true

require_relative '../index'
require_relative '../row'

describe Index do
  it "finds a row by a column" do
    row = Row.new
    row[:name] = "Alice"
    row[:age] = 30
    index = Index.new(:name)
    index.add(row)
    expect(index.find("Alice")).to eq([row])
  end
end
