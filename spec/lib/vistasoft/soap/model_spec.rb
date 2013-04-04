require 'spec_helper'

describe Vistasoft::Soap::Model do
  it "is a HashWithIndifferentAccess" do
    subject.should be_a(HashWithIndifferentAccess)
  end
end

describe Vistasoft::Soap::Model, "#method_missing" do
  context "when method is a hash key" do
    context "with value" do
      subject { described_class.new(attribute: 'value') }
      its(:attribute) { should eq('value') }
    end

    context "with nil value" do
      subject { described_class.new(attribute: nil) }
      its(:attribute) { should be_nil }
    end

    context "when method is not a key" do
      it "raise exception" do
        expect { subject.invalid_attribute }.to raise_error
      end
    end
  end
end