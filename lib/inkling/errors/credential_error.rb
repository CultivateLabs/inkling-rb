module Inkling
  class CredentialError < StandardError
    def to_s
      "Client creation requires a hash containing username and password"
    end
  end
end