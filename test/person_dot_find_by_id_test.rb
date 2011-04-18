require 'test_helper'
class PersonDotFindByIdTest < Test::Unit::TestCase

  def setup
    VCR.use_cassette('person.find_by_id') do
      @organisation = CapsuleCRM::Organisation.find organisations(:gov)
      @person = CapsuleCRM::Person.find people(:pm)
      @person.organisation # to record the request
    end
  end


  # nodoc
  def test_attributes
    assert_equal @person.title, 'Mr'
    assert_equal @person.first_name, 'David'
    assert_equal @person.last_name, 'Cameron'
    assert_equal @person.job_title, 'Prime Minister'
  end


  # nodoc
  def test_organisation
    assert_equal @organisation, @person.organisation
  end


  # nodoc
  def test_addresses
    assert_equal CapsuleCRM::ChildCollection, @person.addresses.class
    assert_equal 1, @person.addresses.size
    @person.addresses.each { |address| assert address.is_a?(CapsuleCRM::Address) }
  end


  # nodoc
  def test_emails
    assert_equal CapsuleCRM::ChildCollection, @person.emails.class
    assert_equal 1, @person.emails.size
    @person.emails.each { |email| assert email.is_a?(CapsuleCRM::Email) }
  end


  # nodoc
  def test_phone_numbers
    assert_equal CapsuleCRM::ChildCollection, @person.phone_numbers.class
    assert_equal 1, @person.phone_numbers.size
    @person.phone_numbers.each { |pn| assert pn.is_a?(CapsuleCRM::Phone) }
  end

  def test_websites
    assert_equal CapsuleCRM::ChildCollection, @person.phone_numbers.class
    assert_equal 1, @person.websites.size
  end

  def teardown
    WebMock.reset!
  end


end
