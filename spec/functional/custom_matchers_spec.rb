describe "Customer Matchers" do
  include_context "user_context"

  describe "user.rabl" do
    rabl_data(:root => 'user'){ user }
    it{ expect(subject).to render_attribute(:guid) }
    it{ expect(subject).to render_attribute(:first_name) }
    it{ expect(subject).to render_attribute(:last_name) }
    it{ expect(subject).to render_attribute(:email) }
    it{ expect(subject).to_not render_attribute(:password) }
  end

  describe "user_aliases.rabl" do
    rabl_data(:root => 'user'){ user }
    it{ expect(subject).to render_attribute(:id).with(:guid) }
    it{ expect(subject).to render_attribute(:team).with_value('Gorby Puff') }
    it{ expect(subject).to render_attribute(:feed_is_deleted).with_value(false) }
  end

  describe "index.rabl" do
    rabl_data(:root => 'users', :object_root => 'user'){ [user] }
    it{ expect(subject).to render_attribute(:guid) }
    it{ expect(subject).to render_attribute(:first_name) }
    it{ expect(subject).to render_attribute(:last_name) }
    it{ expect(subject).to render_attribute(:email) }
    it{ expect(subject).to_not render_attribute(:password) }
  end

  describe "index.rabl" do
    rabl_data(:root => 'foobar'){ [user] }
    it "gives an error specific for missing root" do
      expect{
        expect(subject).to render_attribute(:guid)
      }.to raise_error(RSpec::Rabl::Error, /missing root/i)
    end
  end

  describe "index.rabl" do
    rabl_data(:root => 'users', :object_root => "player"){ [user] }
    it "gives an error specific for incorrect object_root" do
      expect{
        expect(subject).to render_attribute(:guid)
      }.to raise_error(RSpec::Rabl::Error, /missing object root/i)
    end
  end

  describe "rootless_index.rabl" do
    rabl_data(:root => false, :object_root => 'user'){ [user] }
    it{ expect(subject).to render_attribute(:guid) }
    it{ expect(subject).to_not render_attribute(:password) }
  end

  describe "bare_index.rabl" do
    rabl_data(:root => false, :object_root => false){ [user] }
    it{ expect(subject).to render_attribute(:guid) }
    it{ expect(subject).to_not render_attribute(:password) }
  end

  describe "nested/test.rabl" do
    rabl_data(:root => 'test'){ user }
    it{ expect(subject).to render_attribute(:guid) }
  end
end
