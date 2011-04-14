require 'test_helper'
class PartyDotTagsTest < Test::Unit::TestCase

  def setup
    VCR.use_cassette('person.find_by_id') do
      @person = CapsuleCRM::Person.find people(:pm)
    end
  end

  def test_tag_names
    VCR.use_cassette('party.tags') do
      @taglist = @person.tag_names
    end
    assert_equal @taglist.size, 11
  end


  def test_tags_and_tagnames
    VCR.use_cassette('party.tags') do
      @tagnames = @person.tag_names
      @taglist = @person.tags
    end
    assert_equal @tagnames.size, @taglist.size
  end

  def teardown
    WebMock.reset!
  end

end
