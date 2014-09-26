module Inkling
  class Tag < ApiResource

    def self.attributes
      [:id, :name]
    end
    attr_accessor *attributes

  end
end