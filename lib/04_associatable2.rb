require_relative '03_associatable'
require 'byebug'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)

    define_method(name) do

      through_options = self.class.assoc_options[through_name]

      source_options = through_options.model_class.assoc_options[source_name]

      through_id = self.send(through_options.foreign_key)

      results = DBConnection.execute(<<-SQL, through_id)

        SELECT
        #{source_options.table_name}.*
        FROM
        #{through_options.table_name}
        JOIN
        #{source_options.table_name} ON #{through_options.table_name}.#{source_options.foreign_key} = #{source_options.table_name}.#{source_options.primary_key}
        WHERE
        #{through_options.table_name}.#{through_options.primary_key} = ?
      SQL

      source_options.model_class.new(results.first)
    end

  end
end
