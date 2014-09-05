module Inkling
  class Category < ApiResource

    def self.attributes
      [:name, :id, :description]
    end
    attr_accessor *attributes

  end
end
