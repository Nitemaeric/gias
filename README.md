# Get-Information-About-Schools (GIAS) Ruby Gem

This gem provides a Ruby interface to the Department for Education's Get Information About Schools (GIAS) CSV.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "gias"
```

## Usage

To get the list of all schools:

```ruby
Gias::School.all
```

This will:

- Download the latest CSV from the DfE's website.
- Convert the CSV to an array of `Gias::School` objects.

The attribute names are the CSV column names, without parentheses, converted to snake_case.

For example:

```ruby
{
  "LA (code)" => :la_code,
  "PhaseOfEducation (name)" => :phase_of_education_name,
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Nitemaeric/gias.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
