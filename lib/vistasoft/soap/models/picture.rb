module Vistasoft
  module Soap
    module Models
      class Picture < Base

        ATTRIBUTES = [
          :base_url,
          :code,
          :date,
          :description,
          :picture
        ]

        def picture_url
          base_url + picture
        end

      end # Picture
    end
  end
end