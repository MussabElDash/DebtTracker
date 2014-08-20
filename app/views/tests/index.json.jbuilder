json.array!(@tests) do |test|
  json.extract! test, :id, :description, :number
  json.url test_url(test, format: :json)
end
