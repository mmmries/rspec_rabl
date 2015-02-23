shared_examples "time renderer" do
  it { expect(subject).to render_attribute(:created_at).with_value(_rabl_data.created_at.to_i) }
end
