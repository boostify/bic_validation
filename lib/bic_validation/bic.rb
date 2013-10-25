require 'active_support/core_ext/object/try'

module BicValidation
  class Bic

    def initialize(code)
      @code = code.to_s.strip.upcase
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
      !known_bics.include?(country.to_sym) ||
        known_bics[country.to_sym].include?(@code.try(:gsub, /XXX$/, ''))
    end

    def valid?
      of_valid_length? &&
        of_valid_format? &&
        has_valid_country_code? &&
        has_valid_branch_code?
    end

    def invalid?
      !valid?
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

      def known_bics
        {
          DE: bics(:de),
          AT: bics(:at),
          CH: bics(:ch)
        }
      end

      def bics(country)
        BankingData::Bank.where(locale: country).only(:bic)
          .map { |bic| bic.first.gsub(/XXX$/, '') }
          .reject(&:blank?)
          .uniq
      end

      def country_codes
        # http://www.iso.org/iso/country_codes/iso_3166_code_lists/country_\
        # names_and_code_elements.htm
        YAML.load(File.read(File.dirname(__FILE__) + '/country_codes.yml'))
      end
  end
end
