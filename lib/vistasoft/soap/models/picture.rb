module Vistasoft
  module Soap
    module Models
      class Picture < Base

        ATTRIBUTES = [
          :code,
          :picture,
          :base_url,
          :date
        ]

        def picture_url
          base_url + picture
        end

      end # Picture
    end
  end
end