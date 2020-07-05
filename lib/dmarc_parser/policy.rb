# frozen_string_literal: true
require 'nokogiri'
require_relative 'xml_helper'

module DmarcParser
  class Policy
    include XmlHelper
    ATTRIBUTES = [:domain, :adkim, :aspf, :p, :sp, :pct]

    ATTRIBUTES.each do |attr|
      attr_accessor attr
    end

    def initialize(node)
      @node = node
      ATTRIBUTES.each do |attr|
        self.send("#{attr}=", get_text("feedback/policy_published/#{attr}"))
      end
      self.pct = self.pct ? self.pct.to_i : nil
    end
  end
end
