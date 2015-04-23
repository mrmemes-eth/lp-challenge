require 'erubis'
require 'fileutils'
require_relative './taxonomy'

class Emitter
  attr_accessor :template
  attr_accessor :build_dir
  attr_accessor :taxonomy

  def self.file_name(region)
    "#{region.downcase.gsub(/\W/,'_')}.html" if region
  end

  def initialize(build_dir)
    self.template = Erubis::Eruby.new(File.read('template/destination.html.erb'))
    self.build_dir = build_dir
    self.taxonomy = Taxonomy.new('../resources/taxonomy.xml')
    prepare_build_dir
  end

  def call(attrs)
    File.open(File.join(build_dir, title_file_name(attrs)), 'w+') do |f|
      f.write(template.result(template_attrs(attrs)))
    end
  end

  private

  def template_attrs(attrs)
    super_region = taxonomy.find(title(attrs)).ancestor
    { region: title(attrs),
      super_region: {
        name: super_region,
        file: self.class::file_name(super_region) },
      description: attrs[:destination][:introductory][:introduction][:overview] }
  end

  def title(attrs)
    attrs[:destination][:title]
  end

  def title_file_name(attrs)
    self.class::file_name(title(attrs))
  end

  def prepare_build_dir
    FileUtils.rm_rf(self.build_dir)
    FileUtils.mkdir_p(self.build_dir)
    FileUtils.cp('../resources/output-template/static/all.css', self.build_dir)
  end
end
