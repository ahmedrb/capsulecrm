class CapsuleCRM::Address < CapsuleCRM::Contact

  attr_accessor :street
  attr_accessor :city
  attr_accessor :state
  attr_accessor :zip
  attr_accessor :country


  # nodoc
  def self.xml_map
    map = {
      'street' => 'street',
      'city' => 'city',
      'state' => 'state',
      'zip' => 'zip',
      'country' => 'country'
    }
    super.merge map
  end


end
