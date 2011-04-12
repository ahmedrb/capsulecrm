require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/hash'
require 'active_support'
require 'active_model'
require 'httparty'
module CapsuleCRM

  mattr_accessor :account_name
  mattr_accessor :api_token

  # nodoc
  def self.base_uri(account_name)
    "https://#{account_name}.capsulecrm.com"
  end


  # nodoc
  def self.initialize!
    raise ArgumentError, "CapsuleCRM.account_name not defined" if account_name.nil?
    raise ArgumentError, "CapsuleCRM.api_token not defined" if api_token.nil?
    CapsuleCRM::Base.base_uri base_uri(account_name)
    CapsuleCRM::Base.basic_auth api_token, 'x'
  end


end

require 'capsulecrm/record_not_found'
require 'capsulecrm/base'
require 'capsulecrm/party'
require 'capsulecrm/person'
require 'capsulecrm/organisation'
require 'capsulecrm/collection'
require 'capsulecrm/child_collection'
require 'capsulecrm/child'
require 'capsulecrm/custom_field'
require 'capsulecrm/contact'
require 'capsulecrm/email'
require 'capsulecrm/phone'
require 'capsulecrm/address'
