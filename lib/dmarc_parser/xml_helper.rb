require 'nokogiri'

module DmarcParser
  module XmlHelper
    def get_text(xpath)
      @node.xpath(xpath).first.text rescue nil
    end

    def get_timestamp(xpath)
      value = get_text(xpath)
      value ? Time.at(value.to_i) : nil
    end

    def get_int(xpath)
      value = get_text(xpath)
      value ? value.to_i : nil
    end
  end
end
