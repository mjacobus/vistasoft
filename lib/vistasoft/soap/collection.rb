module Vistasoft
  module Soap
    class Collection < Array

      # params are given in the ResponseParser.parse(response) format
      def self.factory(params = {}, klass)
        collection = self.new

        params.each do |key, values|
          if key == key.to_i.to_s
            collection << klass.new(values)
          end
        end

        collection
      end

    end # Collection
  end
end