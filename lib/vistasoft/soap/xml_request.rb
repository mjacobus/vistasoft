require 'builder'

module Vistasoft
  module Soap
    class XmlRequest
      attr_reader :builder, :params

      def initialize(params = {}, builder = Builder::XmlMarkup.new)
        @params = params
        @builder = builder
        build_body
      end

      def to_s
        builder.target!
      end

      def build_body
        builder.param0({'xsi:type' => "ns2:Map"}) do |b|
          params.each do |name, value|
            build_param(b,name,value)
          end
        end
      end

      def build_param(builder, name, value)
        builder.item do |b|
          b.key(name.to_s)

          if value.respond_to?(:each)
            b.value({'xsi:type'=> "ns2:Map"}) do
              value.each do |key, value|
                build_param(b, key, value)
              end
            end
          else
            b.value(value)
          end
        end
      end

    end # XmlRequest
  end
end