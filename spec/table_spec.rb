# frozen_string_literal: true

require_relative '../table'
require_relative '../row'
require_relative '../index'

describe Table do
  it "counts the row" do
    table = Table.new
    24.times do
      table.add_row(Row.new)
    end
    expect(table.row_count).to eq 24
  end

  it "finds a row by id" do
    table = Table.new
    row = Row.new
    table.add_row(row)
    expect(table.find(row.id)).to eq row
  end

  it "does not find a row by id" do
    table = Table.new
    row = Row.new
    table.add_row(row)
    expect(table.find(row.id + 42)).to be_nil
  end

  it "finds a row by a custom column" do
    table = Table.new
    row = Row.new
    row[:name] = "John"
    table.add_row(row)
    expect(table.find_by(:name, "John")).to eq row
  end

  it "does not find a row by a custom column" do
    table = Table.new
    row = Row.new
    row[:name] = "John"
    table.add_row(row)
    expect(table.find_by(:name, "Jane")).to be_nil
  end

  it "finds all rows by a custom column" do
    table = Table.new
    row1 = Row.new
    row1[:name] = "John"
    table.add_row(row1)
    row2 = Row.new
    row2[:name] = "John"
    table.add_row(row2)
    expect(table.find_all_by(:name, "John")).to eq [row1, row2]
  end

  it "successfully adds an index" do
    table = Table.new
    row1 = Row.new
    row1[:name] = "John"
    row2 = Row.new
    row2[:name] = "Jane"
    row3 = Row.new
    table.add_row(row1)
    table.add_row(row2)
    table.add_row(row3)
    table.add_index(:name)
    expect(table.indexes[:name]).to be_a(Index)
  end

  it "finds a row by an indexed column" do
    table = Table.new
    row1 = Row.new
    row1[:name] = "John"
    row2 = Row.new
    row2[:name] = "Jane"
    table.add_row(row1)
    table.add_row(row2)
    table.add_index(:name)

    expect(table.indexes[:name]).to receive(:find).with("John").and_call_original
    expect(table.find_by(:name, "John")).to eq row1
  end
end
