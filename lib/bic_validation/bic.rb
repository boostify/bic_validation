require 'active_support/core_ext/object/try'

module BicValidation
  class Bic

    def initialize(code)
      @code = code.strip.upcase
    end

    def of_valid_length?
      [8, 11].include? @code.length
    end

    def of_valid_format?
      @code =~ format
    end

    def has_valid_country_code?
      country_codes.include? country
    end

    def has_valid_branch_code?
      # WTF? http://de.wikipedia.org/wiki/ISO_9362
      country[0] =~ /[^01]/ && country[1] =~ /[^O]/
    end

    def known?
      !KNOWN_BICS.include?(country.to_sym) ||
        KNOWN_BICS[country.to_sym].include?(@code.try(:gsub, /XXX\$/, ''))
    end

    def valid?
      of_valid_length? &&
        of_valid_format? &&
        has_valid_country_code? &&
        has_valid_branch_code?
    end

    def bank
      match[1]
    end

    def country
      match[2]
    end

    def location
      match[3]
    end

    def branch
      match[4]
    end

    private

      def format
        /([A-Z]{4})([A-Z]{2})([0-9A-Z]{2})([0-9A-Z]{3})?/
      end

      def match
        format.match(@code)
      end

      def self.known_bics
        {
          DE: de_bics,
          AT: at_bics
        }
      end

      def self.de_bics
        bics = []
        File.open(de_bic_file).each_line do |line|
          bics << line[139..149].try(:gsub, /XXX$/, '')
        end
        bics.reject(&:blank?).uniq
      end

      def self.de_bic_file
        File.dirname(__FILE__) + '/../../data/BLZ_20130909.txt'
      end

      def self.at_bics
        bics = []
        opts = { col_sep: ';',
                 file_encoding: 'iso-8859-1',
                 force_simple_split: true }
        SmarterCSV.process(at_bic_file, opts).each do |bank|
          bics << bank[:'swift-code'].try(:gsub, /"/, '').try(:gsub, /XXX$/, '')
        end
        bics.reject(&:blank?).uniq
      end

      def self.at_bic_file
        File.dirname(__FILE__) +
          '/../../data/kiverzeichnis_gesamt_de_1381499802577.csv'
      end

      KNOWN_BICS = known_bics

      def country_codes
        # http://www.iso.org/iso/country_codes/iso_3166_code_lists/country_\
        # names_and_code_elements.htm
        YAML.load(File.read(File.dirname(__FILE__) + '/country_codes.yml'))
      end
  end
end
