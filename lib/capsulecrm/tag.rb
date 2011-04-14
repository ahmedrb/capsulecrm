class CapsuleCRM::Tag < CapsuleCRM::Child

  attr_accessor :name

  # nodoc
  def self.xml_map
    map = {
      'name' => 'name'
    }
    super.merge map
  end
end
