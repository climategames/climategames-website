require "rails_helper"

RSpec.describe ::Ushahidi::Incident do
  describe ".build_from_api_attributes" do
    let(:api_attrs) do
      {
        "incident" => {
          "incidentid" => "34",
          "incidenttitle" => "Video of cat jumping",
          "incidentdescription" => "Video of cat jumping https://www.youtube.com/watch?v=OQzJR3BqS7o",
          "incidentdate" => "2013-06-16 10:32:00",
          "incidentmode" => "1",
          "incidentactive" => "0",
          "incidentverified" => "1",
          "locationid" => "35",
          "locationname" => "House",
          "locationlatitude" => "2.4",
          "locationlongitude" => "3.8"
        },
        "categories" =>
        [
          { "category" => {
            "id" => 1,
            "title" => "Cat"
          }
          },
          { "category" => {
            "id" => 2,
            "title" => "Jumping"
          }
          }
        ],
        "media" => [{ "id" => 143, "type" => 2, "link" => "https://www.youtube.com/watch?v=OQzJR3BqS7o", "thumb" => nil }],
        "comments" => [],
        "customfields" => [] }
    end

    subject { ::Ushahidi::Incident.build_from_api_attributes(api_attrs) }

    its(:id) { should eq 34 }
    its(:title) { should eq "Video of cat jumping" }
    its(:description) { should eq "Video of cat jumping https://www.youtube.com/watch?v=OQzJR3BqS7o" }
    its(:categories) do
      should eq [{ "category" => { "id" => 1, "title" => "Cat" } }, { "category" => { "id" => 2, "title" => "Jumping" } }]
    end
    its(:date) { should eq Time.parse("2013-06-16 10:32:00") }
    its(:latitude) { should eq 2.4 }
    its(:longitude) { should eq 3.8 }
    its(:location_name) { should eq "House" }
    its(:verified) { should be_truthy }
    its(:active) { should be_falsey }
  end
end
