module Vistasoft
  module Soap
    autoload :InvalidAttributeError, 'vistasoft/soap/invalid_attribute_error'
    autoload :ResponseError,         'vistasoft/soap/response_error'
    autoload :ResponseParser,        'vistasoft/soap/response_parser'
    autoload :Service,               'vistasoft/soap/service'
    autoload :XmlRequestMessage,     'vistasoft/soap/xml_request_message'

    module Models
      autoload :Property,           'vistasoft/soap/models/property'
    end

    module Collections
      autoload :PropertyCollection, 'vistasoft/soap/collections/property_collection'
    end
  end
end