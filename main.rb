require './system_params'
require './rack_object'
require './db_connector'

params = SystemParams.new

db_connection = DbConnector.new
entry = RackObject.new(:name => params.hostname, :label => params.hostname,
                   :asset_no => params.hostname, :comment => params.to_hash.to_s)
db_connection.insert_record(entry)
