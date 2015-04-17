require 'sax-machine'
require 'taxonomy'

class Taxonomies
  include SAXMachine
  elements :taxonomy, :as => :taxonomies, class: Taxonomy

  def retrieve(name)
    taxonomies.map do|taxonomy|
      taxonomy.retrieve(name)
    end.first
  end
end
