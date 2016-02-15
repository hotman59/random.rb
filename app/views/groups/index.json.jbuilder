json.array!(@groups) do |group|
  json.extract! group, :id, :name_group, :salle, :tache
  json.url group_url(group, format: :json)
end
