require 'rails_helper'

describe "Creating todo lists", :js, :driver => :webkit do
	
	it "redirects to the todo list index page on success" do
		visit "/todo_lists"

		#save_and_open_page
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: "Capybara Test"
		fill_in "Description", with: "Capybara test description"
		click_button "Create Todo list"

		expect(page).to have_content("Todo list was successfully created.")
	end

	it "displays an error when the todo list has no title", :js, :driver => :webkit do
		expect(TodoList.count).to eq(0)


		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: ""
		fill_in "Description", with: "Capybara test description"
		click_button "Create Todo list"

		expect(page).to have_content("Title can't be blank")
		expect(TodoList.count).to eq(0)
		save_and_open_page

		expect(page).to_not have_content("Capybara test description")

	end

end