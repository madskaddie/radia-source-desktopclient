

require 'rubygems'
require 'Qt4'
require 'active_resource'


$config = {:scheduler_uri => "http://zaki:1234@welles.ist.utl.pt:3000"}

APP_DIR = File.dirname(File.expand_path(__FILE__))

# Sorting done to solve dependencies between files
Dir[File.join(APP_DIR, "/scheduler/*.rb")].sort.each { |z| require z }

require 'scheduler_widget'
require 'broadcast_form'
require 'main_ui'
