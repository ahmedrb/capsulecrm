class CapsuleCRM::Email < CapsuleCRM::Contact

  attr_accessor :address


  # nodoc
  def self.xml_map
    map = {
      'emailAddress' => 'address'
    }
    super.merge map
  end


end
