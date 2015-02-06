require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns

    rows = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    rows[0].map(&:to_sym)

  end

  def self.finalize!

    columns.each do |col|
      define_method(col) { attributes[col] }
      define_method(col.to_s+"=") {|arg| attributes[col] = arg}
    end

  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    parse_all(results)

  end

  def self.parse_all(results)

    results.map do |attrs|
      self.new(attrs)
    end

  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = #{id}
      LIMIT
        1
    SQL

    return nil if results.empty?
    self.new(results.first)

  end

  def initialize(params = {})

    params.each do |attr_name, value|

      unless self.class.columns.include?(attr_name.to_sym)
        raise "unknown attribute '#{attr_name}'"
      end

      setter = (attr_name.to_s+"=").to_sym
      self.send(setter, value)
    end

  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    values = []
    self.class.columns.map do |col|
      values << self.send(col)
    end

    puts "RETURNING #{values}"
    values
  end

  def insert

    attr_cols = self.class.columns[1..-1]

    col_names = attr_cols.join(", ")
    question_marks = (["?"] * attr_cols.count).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values[1..-1])
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id= DBConnection.last_insert_row_id
  end

  def update

    set_line = self.class.columns[1..-1].map do |col|
      "#{col} = ?"
    end.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values[1..-1], id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = ?
    SQL

  end

  def save
    id.nil? ? insert : update
  end
end
