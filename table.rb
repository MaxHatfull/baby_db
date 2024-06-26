# frozen_string_literal: true

class Table
  def initialize
    @next_id = 1
  end

  def add_row(row)
    row.id = @next_id
    @next_id += 1
    rows << row
    indexes.each do |_, index|
      index.add(row)
    end
  end

  def add_index(column)
    indexes[column] = Index.new(column)
    rows.each do |row|
      indexes[column].add(row)
    end
  end

  def indexes
    @indexes ||= {}
  end

  def row_count
    rows.size
  end

  def find(id)
    rows.find { |row| row.id == id }
  end

  def find_by(column, value)
    return indexes[column].find(value) if indexes.key?(column)

    rows.find { |row| row[column] == value }
  end

  def find_all_by(column, value)
    rows.select { |row| row[column] == value }
  end

  private

  def rows
    @rows ||= []
  end
end
