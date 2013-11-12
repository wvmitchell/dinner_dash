require "./test/test_helper"

class CanAddOrEditCategoryTest < Capybara::Rails::TestCase

  test "can add category" do
    visit new_category_path
    fill_in "Name", :with => "Brunch"
    click_button "Create"
    assert_content page, "Brunch"
  end

  test "can't add an existing category" do
    visit new_category_path
    fill_in "Name", :with => "Brunch"
    click_button "Create"
    assert_content page, "Brunch"
    visit new_category_path
    fill_in "Name", :with => "Brunch"
    click_button "Create"
    assert_content page, "This category cannot be created!"
  end

  test "can't add an existing category regardless of case" do
    visit new_category_path
    fill_in "Name", :with => "Brunch"
    click_button "Create"
    assert_content page, "Brunch"
    visit new_category_path
    fill_in "Name", :with => "brunch"
    click_button "Create"
    assert_content page, "This category cannot be created!"
  end

  test "can edit an existing category" do
    visit new_category_path
    fill_in "Name", :with => "Brunch"
    click_button "Create"
    visit new_category_path
    fill_in "Name", :with => "Snacks"
    click_button "Create"
    visit new_category_path
    fill_in "Name", :with => "Plates"
    click_button "Create"

    visit categories_path
    within("#category_3") do
      click_on "Edit"
    end
    assert_content page, "Edit the Plates category"
    fill_in "Name", :with => "Burgers"
    click_button "Edit"
    assert_content page, "Burgers"
    assert_content page, "Brunch"
    assert_content page, "Snacks"
  end


end
