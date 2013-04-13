require 'spec_helper'

describe "alerts/new" do
  before(:each) do
    assign(:alert, stub_model(Alert,
      :name => "MyString",
      :recipients => "MyString",
      :from => "MyString",
      :to => "MyString",
      :sent => false
    ).as_new_record)
  end

  it "renders new alert form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", alerts_path, "post" do
      assert_select "input#alert_name[name=?]", "alert[name]"
      assert_select "input#alert_recipients[name=?]", "alert[recipients]"
      assert_select "input#alert_from[name=?]", "alert[from]"
      assert_select "input#alert_to[name=?]", "alert[to]"
      assert_select "input#alert_sent[name=?]", "alert[sent]"
    end
  end
end
