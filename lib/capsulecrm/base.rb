module CapsuleCRM
  class Base
    include HTTParty
    include ActiveModel::Dirty


    # This is needed for PUT and POST requests because the capsule API returns html
    # if the request is unsuccessful.  HTTParty's default xlm parser crashes if fed
    # html so this parser is used for PUT/POST
    class Parser::Simple < HTTParty::Parser
      def parse; body; end
    end


    # -- Attributes --
    attr_accessor :id
    attr_accessor :raw_data
    @@last_response = nil


    # -- HttpParty --
    format      :xml
    headers     'User-Agent' => 'CapsuleCRM ruby gem'


    # nodoc
    def initialize(attributes={})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
      changed_attributes.clear
    end


    # nodoc
    def ==(other)
      return false if other.nil?
      id == other.id
    end


    # nodoc
    def id
      return nil if @id.nil?
      @id.to_i
    end


    # nodoc
    def errors
      @errors ||= []
    end


    # nodoc
    def new_record?
      id.nil?
    end


    # -- Class Methods --

    
    # nodoc
    def self.find(what, options={})
      return find_all(options) if what == :all
      find_one(what)
    end


    # for debugging
    def self.last_response
      @@last_response
    end


    private


    # uses xml_map() to convert the xml hash from response.data into an attributes hash
    def self.attributes_from_xml_hash(hash)
      attributes = {:raw_data => hash}
      xml_map.each { |k,v| attributes[v] = hash[k] }
      attributes
    end


    # uses xml_map() to convert :attributes into an xml string
    def self.attributes_to_xml(attributes, root=nil)
      xml = {}
      map = xml_map.invert
      attributes.each do |k,v|
        key = map[k.to_s]
        xml[key] = v
      end
      xml.to_xml :root => root
    end


    # nodoc
    def self.find_one(id)
      path = get_path + '/' + id.to_s
      @@last_response = get(path)
      raise_404(id) if last_response.code == 404
      init_one(last_response)
    end


    # nodoc
    def self.find_all(options={})
      params = query_params(options)
      @@last_response = get(get_path, :query => params)
      init_many(last_response)
    end


    # over-ride in sub-classes
    def self.get_path
    end


    # capsule API uses :start.  :offset is prob more familiar to ruby/active_record users
    def self.query_params(options)
      params = options.dup
      params[:start] = params.delete(:offset) if params.has_key?(:offset)
      params
    end


    # nodoc
    def self.raise_404(id)
      err = "Could not find #{name} with id #{id}"
      raise CapsuleCRM::RecordNotFound, err
    end


    # creates a new object, and returns the ID
    # returns false if something went wrong (use last_response() to debug)
    def self.create(attributes, options={})
      return false if attributes.empty?
      xml = attributes_to_xml(attributes, options.delete(:root))
      @@last_response = post options[:path], xml_request_options(xml)
      return false unless last_response.code == 201
      last_response.headers['location'].split('/').last
    end


    # updates an object with the given id, returns true on success, false
    # on failure.
    def self.update(id, attributes, options={})
      return true if attributes.empty?
      xml = attributes_to_xml(attributes, options.delete(:root))
      @@last_response = put options[:path], xml_request_options(xml)
      last_response.code == 200
    end


    # nodoc
    def self.xml_map
      {'id' => 'id'}
    end


    # needed for PUT and POST operations
    def self.xml_request_options(xml)
      options = {
        :body => xml,
        :headers => {'Content-Type' => 'text/xml'},
        :parser => Parser::Simple
      }
    end


  end
end
