class CapsuleCRM::Person < CapsuleCRM::Party

  attr_accessor :about
  attr_accessor :first_name
  attr_accessor :job_title
  attr_accessor :last_name
  attr_accessor :organisation_id
  attr_accessor :title


  define_attribute_methods [:about, :first_name, :last_name, :job_title, :organisation_id, :title]


  # nodoc
  def attributes
    attrs = {}
    arr = [:about, :first_name, :last_name, :title, :job_title]
    arr.each do |key|
      attrs[key] = self.send(key)
    end
    attrs
  end


  # nodoc
  def first_name=(value)
    first_name_will_change! unless value == first_name
    @first_name = value
  end


  # nodoc
  def last_name=(value)
    last_name_will_change! unless value == last_name
    @last_name = value
  end


  # nodoc
  def title=(value)
    title_will_change! unless value == title
    @title = value
  end


  # nodoc
  def organisation
    return nil if organisation_id.nil?
    @organisation ||= CapsuleCRM::Organisation.find(organisation_id)
  end


  # nodoc
  def save
    new_record?? create : update
  end


  private


  # nodoc
  def create
    path = '/api/person'
    options = {:root => 'person', :path => path}
    new_id = self.class.create dirty_attributes, options
    unless new_id
      errors << self.class.last_response.response.message
      return false
    end
    @errors = []
    changed_attributes.clear
    self.id = new_id
    self
  end


  # nodoc
  def dirty_attributes
    Hash[attributes.select { |k,v| changed.include? k.to_s }]
  end


  # nodoc
  def update
    path = '/api/person/' + id.to_s
    options = {:root => 'person', :path => path}
    success = self.class.update id, dirty_attributes, options
    changed_attributes.clear if success
    success
  end


  # -- Class methods --

  
  # nodoc
  def self.init_many(response)
    data = response['parties']['person']
    CapsuleCRM::Collection.new(self, data)
  end


  # nodoc
  def self.init_one(response)
    data = response['person']
    new(attributes_from_xml_hash(data))
  end


  # nodoc
  def self.xml_map
    map = {
      'about' => 'about',
      'firstName' => 'first_name',
      'jobTitle' => 'job_title',
      'lastName' => 'last_name',
      'organisationId' => 'organisation_id',
      'title' => 'title'
    }
    super.merge map
  end


end
