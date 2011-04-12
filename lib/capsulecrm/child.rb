class CapsuleCRM::Child < CapsuleCRM::Base
  attr_accessor :parent


  # nodoc
  def initialize(parent, attributes={})
    @parent = parent
    super(attributes)
  end


  # nodoc
  def self.init_many(parent, data)
    CapsuleCRM::ChildCollection.new(parent, self, data)
  end


  # nodoc
  def self.init_one(parent, data)
    new(parent, attributes_from_xml_map(data))
  end


end
