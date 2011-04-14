require 'rubygems'
# require 'ruby-debug'
require 'test/unit'
require 'webmock/test_unit'
require 'vcr'


# .gemspec does this usually
$: << File.expand_path('../../lib', __FILE__)
require 'capsulecrm'

# initialization - credentials only matter for VCR's first run
CapsuleCRM.account_name = ENV['CAPSULE_ACCOUNT'] || 'foo'
CapsuleCRM.api_token = ENV['CAPSULE_TOKEN'] || 'bar'
CapsuleCRM.initialize!


# nodoc
VCR.config do |c|
  c.cassette_library_dir = 'test/fixtures/responses'
  c.stub_with :webmock
  c.filter_sensitive_data('[API-TOKEN]') { CapsuleCRM.api_token }
  c.filter_sensitive_data('[ACCOUNT-NAME]') { CapsuleCRM.account_name }
  c.filter_sensitive_data('[SESSION-COOKIE]') do |interaction|
    interaction.response.headers['set-cookie'].first
  end
end


# nodoc
class Test::Unit::TestCase

  # nodoc
  def organisations(key)
    ids = {
      :gov => 10185256
    }
    ids[key]
  end


  # nodoc
  def people(key)
    ids = {
      :dpm => 10185261,
      :pm => 10185257
    }
    ids[key]
  end

end
