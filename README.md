[![Build Status](https://travis-ci.org/mmmries/rspec_rabl.svg?branch=master)](https://travis-ci.org/mmmries/rspec_rabl)
[![Code Climate](https://codeclimate.com/github/mmmries/rspec_rabl/badges/gpa.svg)](https://codeclimate.com/github/mmmries/rspec_rabl)
[![Dependency Status](https://gemnasium.com/mmmries/rspec_rabl.svg)](https://gemnasium.com/mmmries/rspec_rabl)

# RspecRabl

A collection of convenient helpers for writing view specs with rabl templates.

## Update Notes

If you were previously using the `rspec_rabl` gem please note that you will need to fix a few things in order to upgrade to the latest version:

* change your Gemfile to require `rspec-rabl` (a hyphen instead of an underscore see #8 for more details)
* in spec\_helper.rb you need to require `rspec/rabl` instead of `rspec_rabl`
* if you are using rails and you want the default configuration you will need to require `rspec/rabl/rails` instead of `rspec/rails_rabl`

## Usage

First make sure you configure rspec-rabl in your spec\_helper.rb file (see Configuration below).

Now your templates can be rendered with whatever data you like for testing:

```ruby
describe "budgets/show/rabl" do                            # this tells us what template you want to test
  let(:budget) { Budget.new }
  rabl_data(:root => 'budget') { budget }                  # this tells us what data to use when rendering and what structure you expect the template to have (use root and object_root just like rabl)

  it "renders valid json" do
    expect {
      JSON.parse(rendered_template)                        # rendered_template is the rendered string
    }.not_to raise_error
  end

  it "renders the data in some specific way" do
    expect(parsed_json['budget']['date']).to eq("1984")    # parsed_json is the parsed out version of the rendered string
  end
end
```

But most of the time you want to check some pretty common things like:

```ruby
describe "budgets/show.rabl" do
  let(:budget) { Budget.new }
  rabl_data(:root => 'budget') { budget }

  it { expect(subject).to render_attribute(:amount) }                        # parsed_json['budget']['amount'] == budget.amount
  it { expect(subject).to render_attribute(:amount).with(:friendly_amount) } # parsed_json['budget']['amount'] == budget.friendly_amount
  it { expect(subject).to render_attribute(:amount).with_value("45.00") }    # parsed_json['budget']['amount'] == "45.00"
end

describe "budgets/index.rabl" do
  let(:budgets) { [ Budget.new ] }
  rabl_data(:root => 'budgets', :object_root => 'budget') { budgets }

  it { expect(subject).to render_attribute(:amount) }                       # parsed_json['budgets'].first['budget']['amount'] == budgets.first.amount
end
```

If you don't want to specify the template you are testing via the describe/context string you can specify the template like this:

```ruby
describe "Users are rendered with the humorous attribute" do
  rabl_template { "users/show.rabl" }
  rabl_data(:root => 'user') { user }

  specify { expect(subject).to render_attribute(:humorous).with_value("not really") }
end
```

## Configuration

The easiest way to configure this is simple

```ruby
require 'rspec/rabl/rails'
```

For more detailed configuration just look at that file to see what configurations it is making.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
