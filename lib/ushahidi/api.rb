require 'open-uri'
require 'json'

module Ushahidi
  class Api
    def incidents(map)
      response_for(map: map, task: :incidents)
    end

    private

    def response_for(map:, task:)
      url = url_for_task(map: map, task: task)
      result = JSON.parse(open(url).read)
      result["payload"][task.to_s].map { |r| Ushahidi::Incident.build_from_api_attributes(r) }
    end

    def endpoint_for_map(map)
      Ushahidi.config["maps"][map]["endpoint"]
    end

    def url_for_task(map:, task:)
      map.endpoint + "?task=#{task}"
    end
  end
end
