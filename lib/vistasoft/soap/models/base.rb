module Vistasoft
  module Soap
    module Models
      class Base

        ATTRIBUTES = []


        attr_reader :attributes

        def initialize(attributes = {})
          @attributes = {}
          self.attributes = attributes
        end

        def attributes=(attributes)
          attributes.each do |key, value|
            if has_attribute?(key)
              @attributes[key.to_sym] = value
            else
              raise ::Vistasoft::Soap::InvalidAttributeError.new(key, self)
            end
          end
        end

        def method_missing(name, *args)
          if has_attribute?(name)
            attributes[name.to_sym]
          else
            super(name, *args)
          end
        end

        def has_attribute?(name)
          self.class::ATTRIBUTES.include?(name.to_sym)
        end

      end # Base
    end
  end
end