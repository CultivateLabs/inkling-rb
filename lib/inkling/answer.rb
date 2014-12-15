module Inkling
  class Answer < ApiResource

    def self.attributes
      [:private, :question_id, :text]
    end
    attr_accessor *attributes
    
  end
end