def response(name)
  File.read("./spec/support/responses/#{name}.xml")
end

RSpec.configure do |config|
  config.before do
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/markets') { [200, {}, response("markets")] }
    end

    allow_any_instance_of(Inkling::Client).to receive(:adapter_opts).and_return([:test, stubs])
  end
end
