require 'spec_helper'

describe Vistasoft::Soap::Collections::PropertyCollection do
  it "behaves like an array" do
    subject.should be_a(Array)
  end
end

describe Vistasoft::Soap::Collections::PropertyCollection, '.factory' do
  let(:prop1) do
    {
      "vista_id"    => '3',
      "category"    => "Apartamentos",
      "price"       => nil,
      "city"        => "Porto Alegre",
      "area"        => "Bairro Remover",
      "bedrooms"    => '5',
      "garages"     => nil,
      "picture"     => "i_9586_3_ceb68.jpg",
      "picture_url" => "http://strg-rse.vistahosting.com.br/wx4imove/vista.imobi/fotos/",
      "description" => nil,
    }
  end

  let(:params) { { "0" =>  prop1, "total_registros" => "1" } }

  it "instantiates new Property" do
    Vistasoft::Soap::Models::Property.should_receive(:new).with(prop1)
    Vistasoft::Soap::Collections::PropertyCollection.factory(params)
  end

  it "instantiate a new PropertyCollection" do
    collection = Vistasoft::Soap::Collections::PropertyCollection.factory(params)
    collection.should be_a(described_class)
  end

  it "adds properties to collection" do
    collection = Vistasoft::Soap::Collections::PropertyCollection.factory(params)
    collection.length.should == 1
    collection.first.should be_a(Vistasoft::Soap::Models::Property)
  end
end