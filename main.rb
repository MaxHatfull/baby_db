# frozen_string_literal: true

require_relative 'table'
require_relative 'row'
require "benchmark"

table = Table.new
1000000.times do
  table.add_row(Row.new)
end

Benchmark.benchmark do |x|
  x.report("Find") do
    100.times do
      table.find(rand(1000000))
    end
  end
end
