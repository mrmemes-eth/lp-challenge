require 'sax-machine'

class Location
  include SAXMachine
  element :node_name, :as => :name
  elements :node, :as => :locations, class: self

  def retrieve(search_name)
    return self if name == search_name
    locations.map do |child_location|
      if child_location.name == search_name
        return child_location
      else
        child_location.retrieve(search_name)
      end
    end.first
  end
end
