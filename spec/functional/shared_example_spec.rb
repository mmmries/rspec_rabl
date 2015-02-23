describe "Shared Examples" do
  describe "budget.rabl" do
    let(:budget) { double('Budget', :created_at => Time.now) }
    rabl_data(:root => 'budget') { budget }
    include_examples "time renderer"
  end
end
