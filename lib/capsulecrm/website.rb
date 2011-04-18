class CapsuleCRM::Website < CapsuleCRM::Child

  attr_accessor :web_address
  attr_accessor :url
  attr_accessor :web_service


  # nodoc
  def self.xml_map
    map = {
      'webAddress' => 'web_address',
      'url' => 'url',
      'webService' => 'web_service'
    }
    super.merge map
  end


end
