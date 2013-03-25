module Vistasoft
  module Soap
    class ResponseParser

      VALUE_TYPES = {
        "ns2:Map"    => :map,
        "xsd:string" => :nil,
        'SOAP-ENC:Array' => :array
      }

      #
      # @param Savon::Response
      # @return Hash
      def parse(response)
        begin
          hash = response.to_hash[:get_response][:return]
          puts "#{value_type(hash)} : #{hash.inspect} \n\n----\n\n"
          if value_type(hash) == :array
            parse_array(hash)
          else
            parse_response_hash(hash)
          end
        rescue Exception => e
          raise ResponseError.new("Could not parase response #{hash.inspect}. Error: #{e.class}: (#{e.message})")
        end
      end


      def parse_map(map)
        parsed = {}
        map.each do |item|
          value = item[:value]
          case value_type(value)
            when :map
              value = parse_map(value[:item])
            when :nil
              value = nil
          end
          parsed[item[:key]] = value
        end
        parsed
      end

      def parse_array(array)
        array[:item]
      end


      def parse_response_hash(hash)
        parse_map(hash[:item])
      end

      def value_type(value)
        if value.respond_to?(:has_key?) && value.has_key?(:"@xsi:type")
          self.class::VALUE_TYPES[value[:"@xsi:type"]]
        else
          :string
        end
      end

    end # ResponseParser
  end
end