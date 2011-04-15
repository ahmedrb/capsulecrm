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
  end

  # nodoc
  def teardown
    WebMock.reset!
  end

end
