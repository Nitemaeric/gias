require "open-uri"
require "csv"
require "active_support/all"

module Gias
  class School
    HOST = "https://ea-edubase-api-prod.azurewebsites.net"

    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
    end

    def inspect
      "#<#{self.class.name} #{attributes.map { |k, v| "#{k}: #{v.inspect}"}.join(", ")}>"
    end

    def method_missing(method_name, *args, &block)
      if attribute_names.include?(method_name.to_s)
        @attributes[method_name.to_s]
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      attribute_names.include?(method_name.to_s) || super
    end

    def attribute_names
      self.class.attribute_names
    end

    class << self
      delegate :first, :last, :size, :count, :length, to: :all

      def all
        @all ||= csv.map do |row|
          new(row.to_h.transform_keys { convert_header(_1) })
        end
      end

      def csv
        @csv ||= CSV.parse(csv_data, headers: true, empty_value: nil)
      end

      def csv_data
        hash = Hash.new do |h, k|
          h[k] = URI.open(HOST + "/edubase/downloads/public/edubasealldata#{k}.csv")
        end

        hash[Date.current.strftime("%Y%m%d")]
      end

      def attribute_names
        @headers ||= csv.headers.map { convert_header(_1) }
      end

      def convert_header(header)
        header.gsub("(", "").gsub(")", "").gsub(" ", "_").underscore
      end
    end
  end
end
