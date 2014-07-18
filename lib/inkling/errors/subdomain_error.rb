module Inkling
  class SubdomainError < StandardError
    def to_s
      "Client creation requires a subdomain"
    end
  end
end