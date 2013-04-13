require 'spec_helper'

describe "alerts/index" do
  before(:each) do
    assign(:alerts, [
      stub_model(Alert,
        :name => "Name",
        :recipients => "Recipients",
        :from => "From",
        :to => "To",
        :sent => false
      ),
      stub_model(Alert,
        :name => "Name",
        :recipients => "Recipients",
        :from => "From",
        :to => "To",
        :sent => false
      )
    ])
  end

  it "renders a list of alerts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Recipients".to_s, :count => 2
    assert_select "tr>td", :text => "From".to_s, :count => 2
    assert_select "tr>td", :text => "To".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
