require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)

    self.all.select do |obj|
      params.all? do |param, value|
        obj.send(param) == value
      end
    end
  end

end

class SQLObject
  extend Searchable
end
