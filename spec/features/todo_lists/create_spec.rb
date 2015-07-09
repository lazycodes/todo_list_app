require 'rails_helper'

describe "Creating todo lists", :driver => :webkit do
	
	it "redirects to the todo list index page on success" do
		visit('/todo_lists')
		#save_and_open_page
		click_link('New Todo list')

		fill_in "Title", with: "Capybara Test"
		fill_in "Description", with: "Capybara test description"
		click_button "Create Todo list"

		expect(page).to have_content("Home")
	end
end