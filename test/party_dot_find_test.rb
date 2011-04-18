require 'test_helper'
class PartyDotFindTest < Test::Unit::TestCase

  def setup
  end

  # nodoc
  def test_find_organisation
    VCR.use_cassette('person.find_by_id') do
      @organisation = CapsuleCRM::Party.find organisations(:gov)
    end
    assert @organisation.is?(:organisation)
  end

  # nodoc
  def test_find_person
    VCR.use_cassette('person.find_by_id') do
      @person = CapsuleCRM::Party.find people(:pm)
    end
    assert @person.is?(:person)
    assert_equal @person.first_name, "David"
  end

  def test_party_without_contacts
    VCR.use_cassette('person.find_by_id') do
      @org = CapsuleCRM::Party.find organisations(:emptyish)
    end

    fields = %w(emails phone_numbers websites addresses)
    fields.each do |field|
      assert @org.send(field).blank?
    end
  end

  # nodoc
  def teardown
    WebMock.reset!
  end

end
