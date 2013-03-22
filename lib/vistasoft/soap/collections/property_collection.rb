module Vistasoft
  module Soap
    module Collections
      class PropertyCollection < Array

        # params are given in the ResponseParser.parse(response) format
        def self.factory(params = {})
          collection = self.new

          params.each do |key, values|
            if key == key.to_i.to_s
              collection << Vistasoft::Soap::Models::Property.new(values)
            end
          end

          collection
        end

      end # Collections
    end
  end
end