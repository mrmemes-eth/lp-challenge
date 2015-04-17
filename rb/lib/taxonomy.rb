require 'sax-machine'
require 'location'

class Taxonomy
  include SAXMachine
  element :taxonomy_name, :as => :name
  elements :node, :as => :locations, class: Location

  def retrieve(location_name)
    locations.map do |location|
      location.retrieve(location_name)
    end.first
  end
end

