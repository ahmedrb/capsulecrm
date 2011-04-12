class CapsuleCRM::Contact < CapsuleCRM::Child

  attr_accessor :type

  # nodoc
  def self.xml_map
    map = {'type' => 'type'}
    super.merge map
  end


end
