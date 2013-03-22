
module Vistasoft
  module Soap
    class InvalidAttributeError < StandardError
      def initialize(attribute, model)
        super("Invalid attribute #{attribute} for class #{model.class}")
      end
    end
  end
end