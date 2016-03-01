json.reports { json.array! @reports do |report|
  json.id report.id
  json.category report.category
  json.team_id report.team_id
  json.title report.title
  json.description report.description
  json.location report.location
  json.longitude report.longitude
  json.latitude report.latitude
  json.image report.primary_picture_url(:thumb)
  json.large_image report.primary_picture_url(:large)
  json.date_time report.date_time.strftime('%d/%m/%Y %H:%M')
end }

json.teams { json.array! @teams do |team|
  json.(team, :id, :name)
end }