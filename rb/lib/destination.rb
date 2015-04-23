require_relative './taxonomy'

class Destination
  attr_accessor :taxonomy
  attr_accessor :name

  def initialize(taxonomy, name)
    self.taxonomy = taxonomy
    self.name = name
  end

  def file_name
    "#{name.downcase.gsub(/\W/,'_')}.html" if name
  end

  def super_region
    self.class::new(taxonomy, taxonomy.find(name).ancestor)
  end

  def sub_regions
    taxonomy.find(name).children.map do |child|
      self.class::new(taxonomy, child)
    end
  end

end
