require 'rails_helper'

describe "Creating todo lists", :js, :driver => :webkit do
	def create_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is my todo list"

		visit "/todo_lists"
		#save_and_open_page
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end

	it "redirects to the todo list index page on success" do
		create_todo_list

		expect(page).to have_content("Todo list was successfully created.")
	end

	it "displays an error when the todo list has no title", :js, :driver => :webkit do
		expect(TodoList.count).to eq(0)
		create_todo_list title: ""

		expect(page).to have_content("Title can't be blank")
		expect(TodoList.count).to eq(0)
		
		visit "/todo_lists"
		expect(page).to_not have_content("Todo list was successfully created.")

	end

	it "displays an error when the todo list has a title less than three characters", :js, :driver => :webkit do
		expect(TodoList.count).to eq(0)
		create_todo_list title: "Hi"

		expect(page).to have_content("Title is too short")
		expect(TodoList.count).to eq(0)
		
		visit "/todo_lists"
		expect(page).to_not have_content("Todo list was successfully created.")

	end	


	it "displays an error when the todo list has no description", :js, :driver => :webkit do
		expect(TodoList.count).to eq(0)
		create_todo_list description: ""

		expect(page).to have_content("Description can't be blank")
		expect(TodoList.count).to eq(0)
		
		visit "/todo_lists"
		expect(page).to_not have_content("Todo list was successfully created.")

	end	

	it "displays an error when the todo list has a description less than five characters", :js, :driver => :webkit do
		expect(TodoList.count).to eq(0)
		create_todo_list description: "Four"

		expect(page).to have_content("Description is too short")
		expect(TodoList.count).to eq(0)
		
		visit "/todo_lists"
		expect(page).to_not have_content("Capybara test description")

	end		
end