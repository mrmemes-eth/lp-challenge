require_relative './hash_ext'
require_relative './taxonomy'

class Destination
  attr_accessor :taxonomy

  def initialize(taxonomy, attrs)
    self.taxonomy = taxonomy
    @attributes = attrs
  end

  def name
    @attributes[:title]
  end

  def overview
    @attributes.get_in(:introductory, :introduction, :overview)
  end

  def file_name
    "#{name.downcase.gsub(/\W/,'_')}.html" if name
  end

  def super_region
    self.class::new(taxonomy, title: taxonomy.find(name).ancestor)
  end

  def sub_regions
    taxonomy.find(name).children.map do |child|
      self.class::new(taxonomy, title: child)
    end
  end

  def attributes
    { region: name,
      super_region: {
        name: super_region.name,
        file: super_region.file_name },
      sub_regions: sub_region_attributes,
      description: overview }
  end

  private

  def sub_region_attributes
    sub_regions.map do |region|
      { name: region.name, file: region.file_name }
    end
  end

end
