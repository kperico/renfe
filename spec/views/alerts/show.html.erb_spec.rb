require 'spec_helper'

describe "alerts/show" do
  before(:each) do
    @alert = assign(:alert, stub_model(Alert,
      :name => "Name",
      :recipients => "Recipients",
      :from => "From",
      :to => "To",
      :sent => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Recipients/)
    rendered.should match(/From/)
    rendered.should match(/To/)
    rendered.should match(/false/)
  end
end
