example_path = File.join( File.dirname(__FILE__), 'support', 'google.xml')

RSpec.describe DmarcParser do
  before do
    @xml_report = File.read(example_path)
  end

  it "has a version number" do
    expect(DmarcParser::VERSION).not_to be nil
  end

  it "reads report metadata" do
    report = DmarcParser::Report.new(@xml_report)
    expect(report.metadata.org_name).to eq('google.com')
    expect(report.metadata.email).to eq('noreply-dmarc-support@google.com')
    expect(report.metadata.extra_contact_info).to eq('https://support.google.com/a/answer/2466580')
    expect(report.metadata.report_id).to eq("3114726731964606297")
    expect(report.metadata.begin_at).to eq(Time.at(1593648000))
    expect(report.metadata.end_at).to eq(Time.at(1593734399))
  end

  it "reads policy published" do
    report = DmarcParser::Report.new(@xml_report)
    expect(report.policy.domain).to eq("opserv.io")
    expect(report.policy.adkim).to eq("r")
    expect(report.policy.aspf).to eq("r")
    expect(report.policy.p).to eq("none")
    expect(report.policy.sp).to eq("none")
    expect(report.policy.pct).to eq(100)
  end

  it "reads report records" do
    report = DmarcParser::Report.new(@xml_report)
    expect(report.records.first.source_ip).to eq("209.85.220.69")
    expect(report.records.first.count).to eq(96)
    expect(report.records.first.disposition).to eq('none')
    expect(report.records.first.dkim).to eq('fail')
    expect(report.records.first.spf).to eq('fail')
    expect(report.records.first.header_from).to eq('opserv.io')
    expect(report.records.first.auth_results.count).to eq(2)
  end
end
