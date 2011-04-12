require 'test_helper'
class CreatePersonTest < Test::Unit::TestCase

  # nodoc
  def setup
  end


  # nodoc
  def test_success
    VCR.use_cassette('create_person') do

      # save a new object, check for the id
      person = CapsuleCRM::Person.new
      person.first_name = 'Homer'
      person.last_name = 'Simpson'
      assert person.save
      assert !person.id.nil?


      # check it was persisted
      person = CapsuleCRM::Person.find person.id
      assert_equal 'Homer', person.first_name
      assert_equal 'Simpson', person.last_name

    end
  end


  # nodoc
  def teardown
    WebMock.reset!
  end


end
