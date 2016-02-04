# QueryableCollection

QueryableCollection allows you to create a collection of objects and then query them based on a (user) defined set of queryable properties

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'queryable_collection'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install queryable_collection

## Usage

Create a list of Arbritrary objects
'''ruby
elements = [Employee.new(name: 'Mr Smith', age: 30), Employee.new(name: 'Mrs Wilson ', age: 45)]
'''

Now define the attributes of that object which are queryable
Note that the object must be able to respond when called with one of these attributes
'''ruby
queryable_attributes = %w(name age)
'''

Now create a queryable collection
'''ruby
queryable_collection = QueryableCollection.create(elements, queryable_attributes)
'''

You can now query this collection
'''ruby
queryable_collection.all # Returns all Employee objects
queryable_collection.first # Returns first Employee object
queryable_collection.where(name: 'Mr Smith') # Returns a QueryableCollection corresponding with the elements that meet the search criteria
queryable_collection.find_by(name: 'Mr Smith') #Returns appropriate Employee object
queryable_collection.empty? #Returns boolean
queryable_collection.to_a #Returns a copy of the original elements array
'''

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/sealink/pansophy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
