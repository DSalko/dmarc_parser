# frozen_string_literal: true
require 'nokogiri'
require_relative 'xml_helper'
require_relative 'auth_result'
require_relative 'reason'

module DmarcParser
  class Record
    include XmlHelper
    ATTRIBUTES = [
      :source_ip, :count, :disposition, :dkim, :spf, :envelope_to, :envelope_from, :header_from, :auth_results, :reasons
    ]

    ATTRIBUTES.each do |attr|
      attr_accessor attr
    end

    def initialize(node)
      @node = node
      self.source_ip = get_text('row/source_ip')
      self.count = get_int('row/count')
      self.disposition = get_text('row/policy_evaluated/disposition')
      self.dkim = get_text('row/policy_evaluated/dkim')
      self.spf = get_text('row/policy_evaluated/spf')
      self.reasons = node.xpath('row/policy_evaluated/reason').map do |reason_node|
        DmarcParser::Reason.new(reason_node)
      end
      self.envelope_to = get_text('identifiers/envelope_to')
      self.envelope_from = get_text('identifiers/envelope_from')
      self.header_from = get_text('identifiers/header_from')
      self.auth_results = node.xpath('auth_results/*').map do |auth_results_node|
        DmarcParser::AuthResult.new(auth_results_node)
      end
    end
  end
end
