domain_dir = File.expand_path('../domain', __FILE__)
app_dir = File.expand_path('../app', __FILE__)
$LOAD_PATH.unshift domain_dir unless $LOAD_PATH.include?(domain_dir)
$LOAD_PATH.unshift app_dir unless $LOAD_PATH.include?(app_dir)

$DATA_PATH = File.expand_path('../data', __FILE__)

require 'pry'
require 'domain'
require 'app'