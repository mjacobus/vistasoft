require 'spec_helper'
require "savon/mock/spec_helper"

describe Vistasoft::Soap::Service, "::SOAP_CLIENT_OPTIONS" do
  it "is predefined" do
    Vistasoft::Soap::Service::SOAP_CLIENT_OPTIONS.should == {
      endpoint: 'http://soap.imo.bi/soap.dll',
      namespace:'http://soap.imo.bi/',
      namespaces: { 'xmlns:ns2' => "http://xml.apache.org/xml-soap" },
      pretty_print_xml: false
    }
  end
end


describe Vistasoft::Soap::Service, "#call" do
  include Savon::SpecHelper
  before(:all) { savon.mock!   }
  after(:all)  { savon.unmock! }

  context "with method busca_imoveis" do

    before do
      @params = busca_imoveis_params
      fixture = File.read("spec/fixtures/busca_imoveis_response.xml")
      xml = xml_request_message(@params).to_s
      savon.expects(:get).with(message: xml).returns(fixture)
    end

    it "gets response as a Savon::Response object" do
      described_class.new(@params).call.should be_a(Savon::Response)
    end

  end
end
