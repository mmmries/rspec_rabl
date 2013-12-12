require 'spec_helper'

describe "User Views" do
  include_context "user_context"
  rabl_data{ user }

  describe "user.rabl" do
    it "should make the rendered template available" do
      rendered_template.should == '{"user":{"guid":"abc","first_name":"gob","last_name":"bluth","email":"gob@bluth.com"}}'
    end

    it "should make the parsed template available" do
      parsed_json.should == {
        'user' => {
          'guid' => user.guid,
          'first_name' => user.first_name,
          'last_name' => user.last_name,
          'email' => user.email,
        }
      }
    end
  end

  describe "test.rabl" do
    rabl_config( {:view_paths => 'spec/fixtures/nested'} )

    it "should allow us to override the Rabl config" do
      parsed_json.should == {'test' => {'guid' => user.guid}}
    end
  end
end
