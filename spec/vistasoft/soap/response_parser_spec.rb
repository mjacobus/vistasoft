# encoding: UTF-8

require 'spec_helper'
require "savon/mock/spec_helper"

describe Vistasoft::Soap::ResponseParser, '#parse' do
  include Savon::SpecHelper
  before(:all) { savon.mock!   }
  after(:all)  { savon.unmock! }

  let(:response) do
    params = busca_imoveis_params
    fixture = File.read("spec/fixtures/busca_imoveis_response.xml")
    xml = xml_request_message(params).to_s
    savon.expects(:get).with(message: xml).returns(fixture)
    Vistasoft::Soap::Service.new(params).call
  end

  let(:parsed) do
    {
      "0" =>  {
        "Codigo"      => '3',
        "Categoria"   => "Apartamentos",
        "Valor"       => nil,
        "Cidade"      => "Porto Alegre",
        "Bairro"      => "Bairro Remover",
        "Dormitorios" => '5',
        "NumeroVagas" => nil,
        "Foto"        => "i_9586_3_ceb68.jpg",
        "Url"         => "http://strg-rse.vistahosting.com.br/wx4imove/vista.imobi/fotos/",
        "Descricao"   => nil,
      },
      "1" => {
        "Codigo"      => '4',
        "Categoria"   => "Apartamentos",
        "Valor"       => nil,
        "Cidade"      => "Porto Alegre",
        "Bairro"      => nil,
        "Dormitorios" => '4',
        "NumeroVagas" => nil,
        "Foto"        => nil,
        "Url"         => "http://strg-rse.vistahosting.com.br/wx4imove/vista.imobi/fotos/",
        "Descricao"   => nil,
      },
      "2" => {
        "Codigo"      => '5',
        "Categoria"   => "Empreendimento",
        "Valor"       => nil,
        "Cidade"      => "Porto Alegre",
        "Bairro"      => nil,
        "Dormitorios" => nil,
        "NumeroVagas" => nil,
        "Foto"        => nil,
        "Url"         => "http://strg-rse.vistahosting.com.br/wx4imove/vista.imobi/fotos/",
        "Descricao"   => nil,
      },
      "total_registros" => "3"
    }
  end

  it "parses response and returns it as a hash" do
    subject.parse(response).should eq(parsed)
  end
end


describe Vistasoft::Soap::ResponseParser, "#parse_response_hash" do
  let(:hash) do
    {:item => [
      {:key=>"0", :value=> {
        :item=>[
          {:key=>"Codigo", :value=>"3"},
          {:key=>"Categoria", :value=>{:"@xsi:type"=>"xsd:string"}}
          ],
          :"@xsi:type"=>"ns2:Map"
        }
      },
      {:key=>"1", :value=> {
        :item=>[
          {:key=>"Codigo", :value=>"4"},
          {:key=>"Categoria", :value=>"Apartamentos"},
        ],
        :"@xsi:type"=>"ns2:Map"}
      },
      {:key=>"total_registros", :value=>"2"}
    ]}
  end

  let(:parsed) do
    {
      "0" => {
        "Codigo" => "3",
        "Categoria" => nil
      },
      "1" => {
        "Codigo" => "4",
        "Categoria" => "Apartamentos"
      },
      "total_registros" => "2"
    }
  end

  it "parses hash" do
    Vistasoft::Soap::ResponseParser.new.parse_response_hash(hash).should eq(parsed)
  end
end


describe Vistasoft::Soap::ResponseParser, "#parse_map" do

  let(:map) do
    [
      {key: "Code",     value:  "5"},
      {key: "Category", value:  "The Category"},
      {key: "Value",    value:  {:"@xsi:type"=>"xsd:string"}},
      {key: "Dimensions", value: {
          :"@xsi:type"=>"ns2:Map",
          item: [ {key: 'width',  value: "3"}, {key: 'height', value: "4"}]
        }
      }
    ]
  end

  let(:parsed) do
    {
      "Code"     => "5",
      "Category" => "The Category",
      "Value"    => nil,
      "Dimensions" => { 'width' => '3', 'height' => '4' }
    }
  end

  it "parses map" do
    Vistasoft::Soap::ResponseParser.new.parse_map(map).should eq(parsed)
  end
end


describe Vistasoft::Soap::ResponseParser, "#value_type" do
  it "recognizes :string type" do
    Vistasoft::Soap::ResponseParser.new.value_type("value").should eq(:string)
  end

  it "recognizes :nil type" do
    Vistasoft::Soap::ResponseParser.new.value_type({:"@xsi:type"=>"xsd:string"}).should eq(:nil)
  end

  it "recognizes :map type" do
    Vistasoft::Soap::ResponseParser.new.value_type({:"@xsi:type"=>"ns2:Map"}).should eq(:map)
  end
end
