require 'spec_helper'

describe Vistasoft::Soap::XmlRequestMessage do
  its(:builder) { should be_a(Builder::XmlMarkup) }
end

describe Vistasoft::Soap::XmlRequestMessage, "#to_s", "with simple params" do
  let(:xml_body) do
    <<-eos
<param0 xsi:type="ns2:Map">
  <item>
    <key>key</key>
    <value>the_key</value>
  </item>
  <item>
    <key>module</key>
    <value>imoveis</value>
  </item>
</param0>
eos
  end

  let(:params) { {:key => 'the_key', :module => 'imoveis'} }
  subject { described_class.new(params, test_builder) }
  its(:to_s) { should eq(xml_body) }
end


describe Vistasoft::Soap::XmlRequestMessage, "#to_s", "with nested params" do
  let(:xml_body) do
    <<-eos
<param0 xsi:type="ns2:Map">
  <item>
    <key>key</key>
    <value>the_key</value>
  </item>
  <item>
    <key>field</key>
    <value xsi:type="ns2:Map">
      <item>
        <key>CODIGO</key>
        <value>Codigo</value>
      </item>
      <item>
        <key>CATEGORIA</key>
        <value>Categoria</value>
      </item>
    </value>
  </item>
</param0>
eos
  end

  let(:params) do
    {
      :key => 'the_key',
      :field => {
        :CODIGO     => 'Codigo',
        'CATEGORIA' => 'Categoria',
      }
    }
  end

  subject { described_class.new(params, test_builder) }
  its(:to_s) { should eq(xml_body) }
end