require 'libxml'
require_relative './location'

class Taxonomy
  attr_accessor :xml_file

  def initialize(file)
    self.xml_file = LibXML::XML::Parser.file(file)
  end

  def document
    @document ||= xml_file.parse
  end

  def find(location)
    Location.new(find_location_node(location))
  end

  private

  def find_location_node(location)
    # we *should* only find one...
    document.find("//node[node_name[text()='#{location}']]").first
  end

end
