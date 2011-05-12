module OrganizzeImporter
  module Parsers
    class Base

      attr_reader :importer

      def initialize(importer)
        @importer = importer
      end

      def parse!
        raise NotImplementedError, "Please define this method in one of my subclasses"
      end

      def main_fields
        raise NotImplementedError, "Please define this method in one of my subclasses"
      end

      def collection_fields
        raise NotImplementedError, "Please define this method in one of my subclasses"
      end
    end
  end
end
