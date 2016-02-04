require 'spec_helper'

describe QueryableCollection do
  let(:elements) { [TestElement.new('first', 1), TestElement.new('second', 2)] }
  let(:queryable_attributes) { %w(name age) }
  let(:queryable_collection) { QueryableCollection.create(elements, queryable_attributes) }
  it 'has a version number' do
    expect(QueryableCollection::VERSION).not_to be nil
  end

  context 'when creating a new collection' do
    context 'with a queryable set of elements ' do
      it 'returns a QueryableCollection::Worker' do
        expect(queryable_collection).to be_a(QueryableCollection::Worker)
      end
    end

    context 'with a no queryable attributes passed in' do
      let(:queryable_attributes) { nil }
      it 'fails with QueryableCollection::Error' do
        expect { queryable_collection }.to raise_error(
          QueryableCollection::Error,
          'Queryable attributes must be a non empty list of attributes'
        )
      end
    end
  end

  context 'when querying collection' do
    context 'running all' do
      it 'should return all elements' do
        expect(queryable_collection.all).to eq elements
      end
    end

    context 'running first' do
      it 'should return the first element' do
        expect(queryable_collection.first).to eq elements.first
      end
    end

    context 'running where with name and age query' do
      let(:refined_collection_object) { queryable_collection.first }
      let(:query) { { name: refined_collection_object.name, age: refined_collection_object.age } }
      let(:refined_collection) { queryable_collection.where(query) }
      it 'should return appropriate worker' do
        expect(refined_collection).to be_a(QueryableCollection::Worker)
        expect(refined_collection.all).to eq [refined_collection_object]
      end
    end

    context 'running find_by with name and age query' do
      it 'should return appropriate element' do
        expect(queryable_collection.find_by(name: 'second', age: 2)).to eq elements[1]
      end
    end

    context 'running find_by with a non queryable attribute' do
      it 'should throw QueryableCollection::Error' do
        expect { queryable_collection.find_by(height: 172) }
          .to raise_error(QueryableCollection::Error, 'Attributes height can\'t be used in query')
      end
    end

    context 'running empty?' do
      it 'should return false' do
        expect(queryable_collection.empty?).to eq false
      end
    end

    context 'running to_a' do
      let(:new_array) { queryable_collection.to_a }
      it 'should return a copy of the original array' do
        expect(new_array).to be_a Array
        expect(new_array).to eq elements
        new_array.pop
        expect(new_array).not_to eq elements
      end
    end
  end

  class TestElement
    attr_accessor :name, :age
    def initialize(name, age)
      @name = name
      @age = age
    end
  end
end
