[![Code Climate](https://codeclimate.com/github/mmmries/rspec_rabl/badges/gpa.svg)](https://codeclimate.com/github/mmmries/rspec_rabl)
[![Dependency Status](https://gemnasium.com/mmmries/rspec_rabl.svg)](https://gemnasium.com/mmmries/rspec_rabl)

# RspecRabl

A collection of convenient helpers for writing view specs with rabl templates.

## Installation

Add this line to your application's Gemfile:

    gem 'rspec_rabl'

## Usage

First make sure you configure rspec\_rabl in your spec\_helper.rb file (see Configuration below).

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

## Configuration

The easiest way to configure this is simple

```ruby
require 'rspec/rails_rabl'
```

For more detailed configuration just look at that file to see what configurations it is making.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
