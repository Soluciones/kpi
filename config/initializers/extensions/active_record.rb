# coding: UTF-8

# Pluck stolen from https://gist.github.com/jcf/1781411 - A reclamar, al maestro armero!
module ActiveRecord
  class Base
    class << self
      delegate :pluck, to: :scoped
    end
  end

  class CollectionProxy
    delegate :pluck, to: :scoped
  end

  # = Active Record Relation
  class Relation
    # Returns <tt>Array</tt> with values of the specified column name
    # The values has same data type as column.
    #
    # Examples:
    #
    #   Person.pluck(:id) # SELECT people.id FROM people
    #   Person.uniq.pluck(:role) # SELECT DISTINCT role FROM people
    #   Person.where(:confirmed => true).limit(5).pluck(:id)
    #
    def pluck(column_name)
      puts "WARNING: Ahora que por fin estamos en Rails 3.2, quita la definición de Pluck, que ya no es necesaria." if Rails.env.development? and Gem::Dependency.new('rails', ">= 3.2").matching_specs.present?

      scope = self.select(column_name)
      self.connection.select_values(scope.to_sql).map! do |value|
        type_cast_using_column(value, column_for(column_name))
      end
    end
  end
end
