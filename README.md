# DMARC Parser

Parses DMARC XML reports for future processing.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dmarc_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dmarc_parser

## Usage

```
  report = DmarcParser::Report.new(xml_string)
```

Getting metadata:

```
  report.metadata
```

Getting DMARC policy information:

```
  report.policy
```

Getting collection of report records:

```
  report.records
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DSalko/dmarc_parser.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
