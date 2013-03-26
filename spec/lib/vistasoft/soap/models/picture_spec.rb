require 'spec_helper'

describe Vistasoft::Soap::Models::Picture, "#attributes" do
  it "raises error when attribute is not in the ATTRIBUTES list" do
    expect {
      subject.attributes= { :unlisted => "value" }
    }.to raise_error(Vistasoft::Soap::InvalidAttributeError)
  end

  context "delegated attributes" do
    Vistasoft::Soap::Models::Picture::ATTRIBUTES.each do |attribute|
      it "respond to ##{attribute}" do
        subject.attributes = { attribute => 'value' }
        subject.send(attribute).should eq('value')
      end
    end
  end

  it "raises error when method method call is not an attribute name" do
    expect {
      subject.invliadattribute
    }.to raise_error
  end
end

describe Vistasoft::Soap::Models::Picture, "#initialize" do
  Vistasoft::Soap::Models::Picture::ATTRIBUTES.each do |attribute|
    it "sets #{attribute} on the initializer" do
      described_class.new({attribute => "value"}).attributes[attribute].should == "value"
    end
  end
end

describe Vistasoft::Soap::Models::Picture, "#picture_url" do
  subject { described_class.new({picture: 'picture.png', base_url: 'http://base/'}) }
  its(:picture_url) { should eq('http://base/picture.png') }
end