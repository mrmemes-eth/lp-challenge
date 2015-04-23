class Location
  attr_accessor :node

  def initialize(node)
    self.node = node
  end

  def ancestor
    if node_name_node = node.find('../node_name').first
      node_name_node.first.content
    else
      nil
    end
  end
end
