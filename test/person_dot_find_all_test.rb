require File.dirname(__FILE__) + '/test_helper'

class PersonDotFindAllTest < Test::Unit::TestCase

  # nodoc
  def setup
    VCR.use_cassette 'person.find_all' do
      @results = CapsuleCRM::Person.find :all
    end
  end


  # nodoc
  def test_return_value_type
    assert_equal CapsuleCRM::Collection, @results.class
  end


  # nodoc
  def test_return_value_size
    assert_equal 6, @results.size
  end


  # nodoc
  def test_offset_parameter
    VCR.use_cassette 'person.find_all_with_offset' do
      @results = CapsuleCRM::Person.find :all, :offset => 3
      assert_requested :get, /capsulecrm.*start=3/
    end
  end


  # nodoc
  def test_limit_parameter
    VCR.use_cassette 'person.find_all_with_limit' do
      @results = CapsuleCRM::Person.find(:all, :limit => 2)
      assert_requested :get, /capsulecrm.*limit=2/
    end
  end


  # nodoc
  def teardown
    WebMock.reset!
  end

end
