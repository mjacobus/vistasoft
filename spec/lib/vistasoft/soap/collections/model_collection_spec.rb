require 'spec_helper'

describe Vistasoft::Soap::Collections::ModelCollection do
  it "behaves like an array" do
    subject.should be_a(Array)
  end
end

describe Vistasoft::Soap::Collections::ModelCollection, '.factory' do
  let(:one) { {title: 'one'} }
  let(:two) { {title: 'two'} }

  let(:params) { { "0" =>  one, "total_registros" => "1" } }

  it "instantiates new Model" do
    Vistasoft::Soap::Model.should_receive(:new).with(one)
    Vistasoft::Soap::Collections::ModelCollection.factory(params)
  end

  it "instantiate a new ModelCollection" do
    collection = Vistasoft::Soap::Collections::ModelCollection.factory(params)
    collection.should be_a(described_class)
  end

  it "adds properties to collection" do
    collection = Vistasoft::Soap::Collections::ModelCollection.factory(params)
    collection.length.should == 1
    collection.first.should be_a(Vistasoft::Soap::Model)
  end
end