# frozen_string_literal: true
require 'nokogiri'
require_relative 'xml_helper'

module DmarcParser
  class AuthResult
    include XmlHelper
    ATTRIBUTES = [:type, :domain, :result, :selector, :scope]

    ATTRIBUTES.each do |attr|
      attr_accessor attr
    end

    def initialize(node)
      @node = node
      self.type = node.name
      self.domain = get_text('domain')
      self.result = get_text('result')
      self.selector = get_text('selector')
      self.scope = get_text('scope')
    end
  end
end
