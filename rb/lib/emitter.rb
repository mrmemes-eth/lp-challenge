require 'erubis'
require 'fileutils'
require_relative './taxonomy'
require_relative './destination'

class Emitter
  attr_accessor :template
  attr_accessor :build_dir
  attr_accessor :taxonomy

  def initialize(build_dir, taxonomy_file_path)
    self.template = Erubis::Eruby.new(File.read('template/destination.html.erb'))
    self.build_dir = build_dir
    self.taxonomy = Taxonomy.new(taxonomy_file_path)
    prepare_build_dir
  end

  def call(attrs)
    dest = Destination.new(taxonomy,attrs[:destination][:title])
    desc = attrs[:destination][:introductory][:introduction][:overview]
    File.open(File.join(build_dir, dest.file_name), 'w+') do |f|
      f.write(template.result(template_attrs(dest,desc)))
    end
  end

  private

  def template_attrs(dest, description)
    { region: dest.name,
      super_region: {
        name: dest.super_region.name,
        file: dest.super_region.file_name },
      sub_regions: dest.sub_regions.map do |region|
        { name: region.name, file: region.file_name }
      end,
      description: description }
  end

  def prepare_build_dir
    FileUtils.rm_rf(self.build_dir)
    FileUtils.mkdir_p(self.build_dir)
    FileUtils.cp('../resources/output-template/static/all.css', self.build_dir)
  end
end
