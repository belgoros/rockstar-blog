module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def ams_json(model, attrs = {})
    resource = model.new(attrs)
    serialization = ActiveModelSerializers::SerializableResource.new(resource)
    serialization.to_json
  end
end
