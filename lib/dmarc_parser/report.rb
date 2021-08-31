require 'nokogiri'
require "bigdecimal/util"
require_relative 'metadata'
require_relative 'policy'
require_relative 'record'

module DmarcParser
  class Report
    include XmlHelper

    def initialize(xml)
      @xml = xml
      @node = Nokogiri::XML(xml)
    end

    def version
      @version ||= BigDecimal(get_text("feedback/version")) if get_text("feedback/version")
    end

    def metadata
      @metadata ||= DmarcParser::Metadata.new(@node)
    end

    def policy
      @policy ||= DmarcParser::Policy.new(@node)
    end

    def records
      @records ||= @node.xpath('feedback/record').map do |node|
        DmarcParser::Record.new(node)
      end
    end
  end
end
