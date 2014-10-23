require 'spec_helper'

describe "User Views" do
  include_context "user_context"
  rabl_data{ user }

  describe "user.rabl" do
    it "makes the rendered template available" do
      expect(rendered_template).to eq '{"user":{"guid":"abc","first_name":"gob","last_name":"bluth","email":"gob@bluth.com"}}'
    end

    it "makes the parsed template available" do
      expect(parsed_json).to eq({
        'user' => {
          'guid' => user.guid,
          'first_name' => user.first_name,
          'last_name' => user.last_name,
          'email' => user.email,
        }
      })
    end
  end

  describe "test.rabl" do
    rabl_config( {:view_paths => 'spec/fixtures/nested'} )

    it "should allow us to override the Rabl config" do
      expect(parsed_json).to eq({'test' => {'guid' => user.guid}})
    end
  end
end
