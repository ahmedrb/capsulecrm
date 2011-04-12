class CapsuleCRM::Phone < CapsuleCRM::Contact

  attr_accessor :number


  # nodoc
  def self.xml_map
    map = {
      'phoneNumber' => 'number'
    }
    super.merge map
  end


end
