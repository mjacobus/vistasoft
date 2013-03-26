require 'spec_helper'

describe Vistasoft::Soap::Collections::PictureCollection do
  it "behaves like an array" do
    subject.should be_a(Array)
  end
end

describe Vistasoft::Soap::Collections::PictureCollection, '.factory' do
  let(:pic1) do
    {
      'code' => '1',
      'picture' => 'name.jpg',
      'base_url' => 'http://base/',
      'date' => '2013-12-01'
    }
  end

  let(:params) { { "0" =>  pic1, "total_registros" => "1" } }

  it "instantiates new Properyt" do
    Vistasoft::Soap::Models::Picture.should_receive(:new).with(pic1)
    Vistasoft::Soap::Collections::PictureCollection.factory(params)
  end

  it "instantiate a new PictureCollection" do
    collection = Vistasoft::Soap::Collections::PictureCollection.factory(params)
    collection.should be_a(described_class)
  end

  it "adds properties to collection" do
    collection = Vistasoft::Soap::Collections::PictureCollection.factory(params)
    collection.length.should == 1
    collection.first.should be_a(Vistasoft::Soap::Models::Picture)
  end
end