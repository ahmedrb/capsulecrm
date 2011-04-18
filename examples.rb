# NOTE: CapsuleCRM::Person and CapsuleCRM::Organisation have virtually identically methods.


# find by id
person = CapsuleCRM::Person.find 123

# or if you don't know what you are searching for Party
something = CapsuleCRM::Party.find 123
something.is?(:person)
something.is?(:organisation)

# find by email
person = CapsuleCRM::Person.find_by_email 'foo@example.com'

# find all
person = CapsuleCRM::Person.find :all, :offset => 10, :limit => 5

# find by search term (searches name, telephone number and searchable custom fields)
person = CapsuleCRM::Person.search 'fred', :offset => 10, :limit => 5

# CapsuleCRM::Person attributes
person.id
person.title
person.first_name
person.last_name
person.job_title
person.about

# update a person object
person.first_name = "Homer"
person.last_name = "Simpson"
person.save # returns true/false

# create a person object
person = CapsuleCRM::Person.new
person.first_name = "Marge"
person.last_name = "Simpson"
person.save # returns true/false


# get the person's organisation
person.organisation # CapsuleCRM::Organisation

# CapsuleCRM::Organisation attributes:
organisation.about
organisation.name


# Contacts: CapsuleCRM::Phone (read-only)
person.phone_numbers # CapsuleCRM::Collection
person.phone_numbers.first.number # 01234 56789
person.phone_numbers.first.type   # work

# Contacts: CapsuleCRM::Website (read-only)
party.websites # CapsuleCRM::Collection
party.websites.first.url # http://google.com
party.websites.first.web_address # http://google.com

# Contacts: CapsuleCRM::Email (read-only)
person.emails # CapsuleCRM::Collection
person.emails.first.address # 'foo@example.com'
person.emails.first.type    # 'home'

# Contacts: CapsuleCRM::Address (read-only)
person.addresses # CapsuleCRM::Collection
person.addresses.first.street   # 10 Somestreet
person.addresses.first.city     # Manchester
person.addresses.first.state    # Greater Manchester
person.addresses.first.zip      # ME10 7TR
person.addresses.first.country  # United Kingdom

# CapsuleCRM::CustomFields (read-only)
person.custom_fields # CapsuleCRM::Collection
person.custom_fields.first.label # 'Favourite colour'
person.custom_fields.first.value # 'Blue'

# CapsuleCRM::Tag (read-only)
person.tags # CapsuleCRM::Collection
person.tag_names # ["array", "of all", "tags", "as strings"]