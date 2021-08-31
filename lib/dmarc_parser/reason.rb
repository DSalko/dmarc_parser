# frozen_string_literal: true

require 'nokogiri'
require_relative 'xml_helper'

module DmarcParser
  class Reason
    include XmlHelper
    ATTRIBUTES = [:type, :comment]

    ATTRIBUTES.each do |attr|
      attr_accessor attr
    end

    def initialize(node)
      @node = node
      self.type = get_text('type')
      self.comment = get_text('comment')
    end
  end
end
