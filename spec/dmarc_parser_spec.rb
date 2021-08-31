example_path = File.join( File.dirname(__FILE__), 'support', 'complete.xml')
google_path = File.join( File.dirname(__FILE__), 'support', 'google.xml')

RSpec.describe DmarcParser do
  before do
    @xml_report = File.read(example_path)
    @google_report = File.read(google_path)
  end

  it "has a version number" do
    expect(DmarcParser::VERSION).not_to be nil
  end

  it "reads report version if available" do
    report = DmarcParser::Report.new(@xml_report)
    expect(report.version).to eq(BigDecimal("0.1"))
    google_report = DmarcParser::Report.new(@google_report)
    expect(google_report.version).to eq(nil)
  end

  it "reads report metadata" do
    report = DmarcParser::Report.new(@xml_report)
    expect(report.metadata.org_name).to eq('google.com')
    expect(report.metadata.email).to eq('noreply-dmarc-support@google.com')
    expect(report.metadata.extra_contact_info).to eq('https://support.google.com/a/answer/2466580')
    expect(report.metadata.report_id).to eq("3114726731964606297")
    expect(report.metadata.begin_at).to eq(Time.at(1593648000))
    expect(report.metadata.end_at).to eq(Time.at(1593734399))
    expect(report.metadata.errors).to eq(["some error", "another error"])
  end

  it "reads policy published" do
    report = DmarcParser::Report.new(@xml_report)
    expect(report.policy.domain).to eq("opserv.io")
    expect(report.policy.adkim).to eq("r")
    expect(report.policy.aspf).to eq("r")
    expect(report.policy.p).to eq("none")
    expect(report.policy.sp).to eq("none")
    expect(report.policy.pct).to eq(100)
    expect(report.policy.fo).to eq("1")
  end

  it "reads report records" do
    report = DmarcParser::Report.new(@xml_report)
    expect(report.records.first.source_ip).to eq("209.85.220.69")
    expect(report.records.first.count).to eq(96)
    expect(report.records.first.disposition).to eq('none')
    expect(report.records.first.dkim).to eq('fail')
    expect(report.records.first.spf).to eq('fail')
    expect(report.records.first.reasons.count).to eq(2)
    expect(report.records.first.reasons.first.type).to eq("local_policy")
    expect(report.records.first.reasons.first.comment).to eq("arc=pass")
    expect(report.records.first.reasons.last.type).to eq("other")
    expect(report.records.first.reasons.last.comment).to eq("dkim=pass")
    expect(report.records.first.envelope_to).to eq('envelope-to.io')
    expect(report.records.first.envelope_from).to eq('envelope-from.io')
    expect(report.records.first.header_from).to eq('opserv.io')
    expect(report.records.first.auth_results.count).to eq(2)
    expect(report.records.first.auth_results.first.type).to eq("dkim")
    expect(report.records.first.auth_results.first.domain).to eq("condenast-com-tw.20150623.gappssmtp.com")
    expect(report.records.first.auth_results.first.result).to eq("pass")
    expect(report.records.first.auth_results.first.selector).to eq("20150623")
    expect(report.records.first.auth_results.last.type).to eq("spf")
    expect(report.records.first.auth_results.last.domain).to eq("condenast.com.tw")
    expect(report.records.first.auth_results.last.result).to eq("neutral")
    expect(report.records.first.auth_results.last.scope).to eq("mfrom")
  end
end
