require 'spec_helper'

describe "User Views" do
  let(:user){ double('user',
    guid: 'abc',
    first_name: 'gob',
    last_name: 'bluth',
    email: 'gob@bluth.com')
  }
  rabl_data{ user }

  describe "user.rabl", :rabl => true do
    it "should render the template" do
      rendered_template.should == '{"user":{"guid":"abc","first_name":"gob","last_name":"bluth","email":"gob@bluth.com"}}'
    end

    it "should render the template parse it" do
      parsed_json.should == {
        'user' => {
          'guid' => user.guid,
          'first_name' => user.first_name,
          'last_name' => user.last_name,
          'email' => user.email,
        }
      }
    end

    it{ should be_a(Rabl::Renderer) }
  end

  describe "test.rabl" do
    rabl_config( {:view_paths => 'spec/fixtures/nested'} )

    it "should render the test.rabl template" do
      parsed_json.should == {'test' => {'guid' => user.guid}}
    end
  end
end
