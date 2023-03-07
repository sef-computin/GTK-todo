
require 'gtk3'
require 'fileutils'

application_root_path = File.expand_path(__dir__)

Dir[__dir__+"/application/ui/todo/*"].each {|file| require file }

resource_xml = File.join(application_root_path, 'resources', 'gresources.xml')
resource_bin = File.join(application_root_path, 'gresource.bin')


system("glib-compile-resources", "--target", resource_bin, "--sourcedir", File.dirname(resource_xml), resource_xml)

resource = Gio::Resource.load(resource_bin)
Gio::Resources.register(resource)

at_exit do
  # Before existing, please remove the binary we produced, thanks.
  FileUtils.rm_f(resource_bin)
end
  

app = ToDo::Application.new
puts app.run