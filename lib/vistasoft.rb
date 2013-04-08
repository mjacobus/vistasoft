module Vistasoft
  module Soap
    autoload :Model,                 'vistasoft/soap/model'
    autoload :ResponseError,         'vistasoft/soap/response_error'
    autoload :ResponseParser,        'vistasoft/soap/response_parser'
    autoload :Service,               'vistasoft/soap/service'
    autoload :XmlRequestMessage,     'vistasoft/soap/xml_request_message'

    module Collections
      autoload :Base,               'vistasoft/soap/collections/base'
      autoload :ModelCollection,    'vistasoft/soap/collections/model_collection'
    end
  end
end