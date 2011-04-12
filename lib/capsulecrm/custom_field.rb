class CapsuleCRM::CustomField < CapsuleCRM::Child

  attr_accessor :boolean
  attr_accessor :date
  attr_accessor :label
  attr_accessor :text


  # nodoc
  def boolean=(value)
    return @boolean = true if value.to_s == 'true'
    @boolean = false
  end


  # nodoc
  def date=(value)
    value = Time.parse(value) if value.is_a?(String)
    @date = value
  end


  # nodoc
  def value
    date || text || boolean
  end


  # nodoc
  def self.xml_map
    map = {
      'label' => 'label',
      'text' => 'text',
      'date' => 'date',
      'boolean' => 'boolean'
    }
    super.merge map
  end


end
