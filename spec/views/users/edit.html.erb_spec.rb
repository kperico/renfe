require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :login => "MyString",
      :passwd => "MyString",
      :admin => false
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "input#user_login[name=?]", "user[login]"
      assert_select "input#user_passwd[name=?]", "user[passwd]"
      assert_select "input#user_admin[name=?]", "user[admin]"
    end
  end
end
