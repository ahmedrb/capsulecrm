class CapsuleCRM::Organisation < CapsuleCRM::Party

  attr_accessor :about
  attr_accessor :name


  # nodoc
  def people
    return @people if @people
    path = self.class.get_path
    path = [path, '/', id, '/people'].join
    last_response = self.class.get(path)
    @people = CapsuleCRM::Person.init_many(last_response)
  end


  # nodoc
  def self.init_many(response)
    data = response['parties']['organisation']
    CapsuleCRM::Collection.new(self, data)
  end


  # nodoc
  def self.init_one(response)
    data = response['organisation']
    new(attributes_from_xml_hash(data))
  end


  # nodoc
  def self.xml_map
    map = {
      'about' => 'about',
      'name' => 'name'
    }
    super.merge map
  end


end
