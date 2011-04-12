class CapsuleCRM::ChildCollection < CapsuleCRM::Collection


  # nodoc
  def initialize(parent, klass, data)
    return if data.nil?
    [data].flatten.each do |attributes|
      attributes = klass.attributes_from_xml_hash(attributes)
      self.push klass.new(parent, attributes)
    end
  end


end
