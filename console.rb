require ('pry')
require_relative('models/property_tracker.rb')

Property.delete_all()

property1 = Property.new({
  'address' => '3149 N. Humboldt',
  'value' => 200000,
  'num_of_bedrooms' => 2,
  'year_built' => 1931
  })

  property1.save()

  binding.pry

  nil
