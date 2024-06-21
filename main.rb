# frozen_string_literal: true

require_relative 'table'
require_relative 'row'
require_relative 'index'
require "benchmark"

table = Table.new
table.add_index(:name)
10_000_000.times do
  row = Row.new
  row[:name] = rand(100_000).to_s
  table.add_row(row)
end

Benchmark.benchmark do |x|
  x.report("Find By") do
    100.times do
      table.find_by(:name, rand(100_000).to_s)
    end
  end
end
