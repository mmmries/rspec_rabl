shared_examples "full name renderer" do
  it { should render_attribute(:first_name) }
  it { should render_attribute(:last_name) }
end
