require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :login => "MyString",
      :passwd => "MyString",
      :admin => false
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", users_path, "post" do
      assert_select "input#user_login[name=?]", "user[login]"
      assert_select "input#user_passwd[name=?]", "user[passwd]"
      assert_select "input#user_admin[name=?]", "user[admin]"
    end
  end
end
