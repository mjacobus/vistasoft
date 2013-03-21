module Vistasoft
  module Soap
    class Service

      SOAP_CLIENT_OPTIONS = {
        endpoint: 'http://soap.imo.bi/soap.dll',
        namespace:'http://soap.imo.bi/',
        namespaces: { 'xmlns:ns2' => "http://xml.apache.org/xml-soap" },
        pretty_print_xml: false
      }

      def initialize(params = {})
        @client = Savon.client(self.class::SOAP_CLIENT_OPTIONS)
        @params = params
      end

      def call
        xml = Vistasoft::Soap::XmlRequestMessage.new(@params).to_s
        @client.call(:get, message: xml)
      end

    end # Service
  end
end