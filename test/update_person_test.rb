require 'test_helper'
class UpdatePersonTest < Test::Unit::TestCase

  # nodoc
  def setup
  end


  # nodoc
  def test_with_changes
    VCR.use_cassette('update_person') do

      # get the person, cache the first name
      person = CapsuleCRM::Person.find people(:dpm)
      first_name = person.first_name
      new_name = first_name.reverse

      # change the name and update
      person.first_name = new_name
      assert person.save

      # reload and check updates were saved
      person = CapsuleCRM::Person.find person.id
      assert_equal new_name, person.first_name

    end
  end


  # nodoc
  def test_without_changes
    VCR.use_cassette('update_person_without_changes') do
      person = CapsuleCRM::Person.find people(:dpm)
      assert person.save
      assert_requested :put, /capsulecrm/, :times => 0
    end
  end


  # nodoc
  def teardown
    WebMock.reset!
  end


end
