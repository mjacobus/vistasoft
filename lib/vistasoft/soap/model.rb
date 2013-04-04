require 'active_support/hash_with_indifferent_access'

module Vistasoft
  module Soap
    class Model < HashWithIndifferentAccess

      def method_missing(method_name, *args)
        if include?(method_name)
          self[method_name]
        else
          super(method_name, *args)
        end
      end

    end # Model
  end
end