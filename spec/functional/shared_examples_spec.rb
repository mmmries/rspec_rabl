require 'support/full_name_renderer_examples'

RSpec.describe "using shared examples" do
  include_context "user_context"
  rabl_template { "user.rabl" }
  rabl_data(:root => 'user'){ user }

  include_examples "full name renderer"
  it_behaves_like "full name renderer"
  it_should_behave_like "full name renderer"
end
