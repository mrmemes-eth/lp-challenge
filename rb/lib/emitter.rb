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
    destination = Destination.new(taxonomy,attrs[:destination])
    File.open(File.join(build_dir, destination.file_name), 'w+') do |f|
      f.write(template.result(destination.attributes))
    end
  end

  private

  def prepare_build_dir
    FileUtils.rm_rf(self.build_dir)
    FileUtils.mkdir_p(self.build_dir)
    FileUtils.cp('../resources/output-template/static/all.css', self.build_dir)
  end
end
