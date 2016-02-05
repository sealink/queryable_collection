require 'adamantium'

module QueryableCollection
  class Worker
    include Adamantium

    def initialize(elements, queryable_attributes)
      @elements = Array(elements)
      fail(Error, 'Queryable attributes must be a non empty list of attributes') unless
        valid_queryable_attributes? queryable_attributes
      @queryable_attributes = queryable_attributes.map(&:to_s)
    end

    def all
      @elements
    end

    def first
      @elements.first
    end

    def where(query)
      self.class.new(select(query), @queryable_attributes)
    end

    def find_by(query)
      where(query).first
    end

    def empty?
      @elements.empty?
    end

    def to_a
      @elements.dup
    end

    private

    def valid_queryable_attributes?(queryable_attributes)
      queryable_attributes.is_a?(Enumerable) && !queryable_attributes.empty?
    end

    def select(query)
      Query.new(query, @queryable_attributes).perform(@elements)
    end

    class Query
      def initialize(query, queryable_attributes)
        @query = query
        @queryable_attributes = queryable_attributes
        validate!
      end

      def perform(elements)
        elements.select { |element|
          @query.all? { |attribute, value|
            element.send(attribute) == value
          }
        }
      end

      private

      def queryable?(attribute)
        @queryable_attributes.include?(attribute.to_s)
      end

      def validate!
        non_queryable_attributes = @query.keys.reject { |attribute| queryable?(attribute) }
        return if non_queryable_attributes.empty?
        fail Error, "Attributes #{non_queryable_attributes.join(', ')} can't be used in query"
      end
    end
  end

  Error = Class.new(StandardError)
end
