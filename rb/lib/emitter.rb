require 'erubis'
require 'fileutils'

class Emitter
  attr_accessor :template
  attr_accessor :build_dir

  def initialize(build_dir)
    self.template = Erubis::Eruby.new(File.read('template/destination.html.erb'))
    self.build_dir = build_dir
    prepare_build_dir
  end

  def call(attributes)
    File.open("#{File.join(build_dir, title_file_name(attributes))}.html", 'w+') do |f|
      f.write(template.result(:attrs => attributes))
    end
  end

  private

  def title_file_name(attributes)
    attributes[:destination][:title].downcase.gsub(/\W/,'_')
  end

  def prepare_build_dir
    FileUtils.rm_rf(self.build_dir)
    FileUtils.mkdir_p(self.build_dir)
    FileUtils.cp('../resources/output-template/static/all.css', self.build_dir)
  end
end
