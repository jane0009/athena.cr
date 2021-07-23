require "json"

class Model
  include JSON::Serializable
  @@name = "undef"
  @id : String

  def self.get_name
    @@name
  end

  def self.get_id
    @id
  end
end
