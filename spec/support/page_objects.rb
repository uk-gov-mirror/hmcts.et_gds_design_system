require 'site_prism'
Dir[File.absolute_path(File.join('page_objects', '**', '*.rb'), __dir__)].sort.each { |f| require f }
