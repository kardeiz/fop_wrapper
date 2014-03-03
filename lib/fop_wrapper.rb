require "fop_wrapper/version"
require 'java'

FOP_ROOT = File.expand_path('../../vendor/fop-1.1', __FILE__)

require File.join(FOP_ROOT, 'build/fop.jar')
Dir.glob( File.join(FOP_ROOT, 'lib/*.jar') ) do |file|
  require file
end

require 'fop_wrapper/transformer'

module FopWrapper; end
