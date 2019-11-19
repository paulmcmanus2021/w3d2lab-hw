require ('minitest/autorun')
require ('minitest/reporters')
require_relative ('../models/property_tracker.rb')

MiniTest::Reporters.use! Minitest::Reporters::SpecReporter.new

class PropertyTrackerTest < MiniTest::Test

  def test_can_create_new_property
    property_details = {
      'address' => '3149 N. Humboldt',
      'value' => 200000,
      'num_of_bedrooms' => 2,
      'year_built' => 1931
    }

    new_property = Property.new(property_details)
    assert_equal(200000,new_property.value)
  end




#
end
