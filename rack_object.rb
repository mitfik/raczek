class RackObject

  attr_accessor :name, :label, :objtype_id, :asset_no, :has_problems, :comment

  # default value in RackTables for Server
  SERVER_TYPE = 4

  def initialize(options = {})
    @name = options[:name]
    @label = options[:label]
    @objtype_id = options[:objtype_id] || SERVER_TYPE
    @asset_no = options[:asset_no]
    @has_problems = options[:has_problems] || "no"
    @comment = options[:comment]
  end

  def to_hash
    {:name => @name, :label => @label, :objtype_id => @objtype_id,
     :asset_no => @asset_no, :has_problems => @has_problems, :comment => @comment}
  end

end
