require 'spec_helper'

describe "User Views" do
  let(:user){ mock('user',
    guid: 'abc',
    first_name: 'gob',
    last_name: 'bluth',
    email: 'gob@bluth.com')
  }

  describe "user.rabl" do
    it "should render the template" do
      template.should == '{"user":{"guid":"abc","first_name":"gob","last_name":"bluth","email":"gob@bluth.com"}}'
    end

    it "should render the template parse it" do
      parsed.should == {
        'user' => {
          'guid' => user.guid,
          'first_name' => user.first_name,
          'last_name' => user.last_name,
          'email' => user.email,
        }
      }
    end
  end
end
