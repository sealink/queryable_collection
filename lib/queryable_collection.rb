module QueryableCollection
  def self.create(elements, queryable_attributes)
    QueryableCollection::Worker.new elements, queryable_attributes
  end
end

require 'queryable_collection/worker'
