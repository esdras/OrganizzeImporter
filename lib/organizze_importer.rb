require "active_support/core_ext/module/delegation"
require "ofx"

module OrganizzeImporter
  autoload :Importer, 'organizze_importer/importer'
  autoload :Parsers, 'organizze_importer/parsers'
end
