module OrganizzeImporter

  class ParserNotFound < ArgumentError; end;
  class Importer

    attr_accessor :file
    attr_reader :parser

    def initialize(file_or_path)
      @file = guess_if_is_file_or_path(file_or_path)
      @parser = choose_parsers_based_on_extension
    end

    def parse!
      parser.parse!
    end

    delegate :collection, :main_fields, :collection_fields, :to => :parser

    def ofx?
      file_extension == "ofx"
    end

    def method_missing(method, *args)
      if parser.main_fields.include?(method.to_sym)
        parser.send(method, *args)
      else
        super
      end
    end

    private

    def choose_parsers_based_on_extension
      if ofx?
        Parsers::OFX.new(self)
      else
        raise ParserNotFound, "We could not find a parser for this file, please make sure your file have the right type and the right extension"
      end
    end

    def guess_if_is_file_or_path(file_or_path)
      if file_or_path.respond_to?(:read)
        file_or_path
      else
        File.open(file_or_path, 'r')
      end
    end

    def file_extension
      path = file.respond_to?(:original_filename) ? file.original_filename : file.path
      File.extname(path).delete('.').downcase
    end

  end
end

