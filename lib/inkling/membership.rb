module Inkling
  class Membership < ApiResource

    def self.attributes
      [:id, :portfolio, :active, :first_name, :last_name, :login, :email, :balance, :answers]
    end
    attr_accessor *attributes

    def answers
      @answers ||= []
    end
  end
end
