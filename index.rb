# frozen_string_literal: true

class Index
  attr_reader :column

  def initialize(column, data = [])
    @column = column
    @data = IndexTree::Leaf.new(column)
    data.each do |row|
      add(row)
    end
  end

  def add(row)
    @data = @data.add(row)
  end

  def find(value)
    @data.find(value)
  end
end

module IndexTree
  class Node
    def initialize(column, contents)
      @column = column
      sorted_contents = contents.map { |r| r[column] }.sort.uniq
      @center = sorted_contents[sorted_contents.length / 2]
      @left = Leaf.new(column)
      @right = Leaf.new(column)
      contents.each do |row|
        add(row)
      end
    end

    def add(row)
      if row[@column] < @center
        @left = @left.add(row)
      else
        @right = @right.add(row)
      end
      self
    end

    def find(value)
      if value < @center
        @left.find(value)
      else
        @right.find(value)
      end
    end
  end

  class Leaf
    def initialize(column)
      @column = column
      @values = Set.new
    end

    def add(row)
      contents << row
      @values << row[@column]
      if @values.length > 10
        Node.new(@column, contents)
      else
        self
      end
    end

    def find(value)
      contents.find { |row| row[@column] == value }
    end

    private

    def contents
      @contents ||= []
    end
  end
end
