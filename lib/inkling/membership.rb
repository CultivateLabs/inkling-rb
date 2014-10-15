module Inkling
  class Membership < ApiResource

    def self.attributes
      [:id, :portfolio, :active, :first_name, :last_name, :login, :email, :balance]
    end
    attr_accessor *attributes

  end
end
