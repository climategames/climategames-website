module Ushahidi
  class Incident
    def self.build_from_api_attributes(api_attributes)
      incident_attrs = api_attributes["incident"]
      attrs = {
        id: incident_attrs["incidentid"].to_i,
        title: incident_attrs["incidenttitle"],
        description: incident_attrs["incidentdescription"],
        categories: api_attributes["categories"],
        date: Time.parse(incident_attrs["incidentdate"]),
        longitude: incident_attrs["locationlongitude"].to_f,
        latitude: incident_attrs["locationlatitude"].to_f,
        location_name: incident_attrs["locationname"],
        verified: incident_attrs["incidentverified"] == "1",
        active: incident_attrs["incidentactive"] == "1"
      }
      new(attrs)
    end

    attr_accessor :id, :title, :description, :categories, :date, :latitude, :longitude, :location_name, :verified, :active

    def initialize(id:,
                   title:,
                   description:,
                   categories:,
                   date:,
                   latitude:,
                   longitude:,
                   location_name:,
                   verified:,
                   active:)

      @id = id
      @title = title
      @description = description
      @categories = categories
      @date = date
      @latitude = latitude
      @longitude = longitude
      @location_name = location_name
      @verified = verified
      @active = active
    end      
  end
end
