require 'mysql2'

class DbConnector

  attr_accessor :client

  def initialize(options = nil)
    options = YAML.load_file("database.yml") unless options
    default_options = {:symbolize_keys => true}
    options.merge!(default_options)
    @client = Mysql2::Client.new(options)
  end

  def insert_record(object)
    object_hash = object.to_hash
    column_names = object_hash.keys.join(",")
    column_values = "'" + object_hash.values.join("','") + "'"
    insert_query = "INSERT INTO Object (#{column_names})
    VALUES (#{column_values})"
    @client.query insert_query
  end

end
