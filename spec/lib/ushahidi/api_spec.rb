require "rails_helper"

RSpec.describe Ushahidi::Api do
  let(:map) { Map.create(slug: "briston", endpoint: "http://bristol.map/api") }
  let(:response_json) do
    {
      "payload" => {
        "incidents" => []
      }
    }
  end

  before do
    allow_any_instance_of(::Ushahidi::Api).to receive_message_chain(:open, :read).and_return('Remote server response')
    allow(map).to receive(:endpoint).and_return("http://bristol.map/api")
  end

  describe "incidents" do
    it "returns an empty array if there are no incidents in ushahidi" do
      allow(JSON).to receive(:parse).and_return(response_json)
      expect(::Ushahidi::Api.new.incidents(map)).to be_empty
    end

    it "queries the correct url" do
      allow(JSON).to receive(:parse).and_return(response_json)
      api = ::Ushahidi::Api.new
      expect(api).to receive(:open).with("http://bristol.map/api?task=incidents").and_return(double("response", read: ""))
      api.incidents(map)
    end

    it "parses the response from the ushahidi request" do
      allow(JSON).to receive(:parse).and_return(response_json)
      expect(JSON).to receive(:parse).with("Remote server response")
      ::Ushahidi::Api.new.incidents(map)
    end

    it "returns an the expected incident object from the example json response" do
      api = ::Ushahidi::Api.new
      response_json_example = File.read(Rails.root.join('spec', 'assets', 'ushahidi', 'incidents.json'))
      allow(api).to receive_message_chain(:open, :read).and_return(response_json_example)
      incidents = api.incidents(map)
      expect(incidents.size).to eq 2
      expect(incidents[0].title).to eq "Mother earth is speaking"
      expect(incidents[1].title).to eq "The rainforest is speaking"
    end
  end
end
