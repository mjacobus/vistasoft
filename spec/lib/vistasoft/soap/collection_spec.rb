require 'spec_helper'

describe Vistasoft::Soap::Collection, ".factory" do

  let(:params) do
    {
      '0' => { 'a' => 'b'},
      '1' =>  {'c' => 'd'},
      'total_records' => '2'
    }
  end

  context "when klass is a Hash" do
    let(:klass) { Hash }
    it "creates a collection of Hash" do
      described_class.factory(params, klass).first.should be_a(klass)
    end
  end

  context "when klass is a Vistasoft::Soap::Model" do
    let(:klass) { Vistasoft::Soap::Model }
    it "creates a collection of HashWithIndifferentAccess" do
      described_class.factory(params, klass).first.should be_a(klass)
    end
  end

end