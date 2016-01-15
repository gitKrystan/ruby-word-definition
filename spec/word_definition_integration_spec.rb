require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the Mos Definition page', {:type => :feature}) do
  before() do
    Word.clear()
  end

  describe('Add a Word path') do
    it('creates a new word which displays on the success page \
        and in a list on the home page') do
      add_test_word()
      expect_the_word_on_the_page()
      click_home_button()
      expect_the_word_on_the_page()
    end
  end

  describe('Add a Definition with a New Word path') do
    it('creates a new word and definition which display on the word page') do
      add_test_word_and_definition()
      expect_the_word_on_the_page()
      expect_the_definition_on_the_page()
    end
  end

  describe('Select a Word path') do
    it('shows the viewer a selected word from the list on the index page') do
      add_test_word()
      click_home_button()
      click_test_word()
      expect_the_word_on_the_page()
    end
  end

  describe('Add a New Definition path') do
    it('adds a new definition to an existing word') do
      add_test_word()
      click_edit_entry()
      fill_in_test_definition()
      click_button('Add')
      expect_the_definition_on_the_page()
    end
  end

  describe('Delete a Word path') do
    it('deletes a word of the users choice') do
      add_test_word()
      click_home_button()
      click_test_word()
      click_button('Remove Word')
      expect_the_word_to_be_removed()
    end
  end

  describe('Delete a Definition path') do
    it('deletes a definition of the users choice') do
      #TODO
    end
  end

  describe('change a word entry path') do
    it('allows users to change words and definition') do
      #TODO
    end
  end

  describe('specify definition type path') do
    it('adds a definition type to an entry') do
      #TODO: e.g. noun, verb, etc
    end
  end
end

def add_test_word
  visit('/')
  click_link('Add Word')
  fill_in_test_word()
  click_button('Add')
end

def add_test_word_and_definition
  visit('/')
  click_link('Add Word')
  fill_in_test_word()
  fill_in_test_definition()
  click_button('Add')
end

def fill_in_test_word
  fill_in('word', :with => 'test')
end

def fill_in_test_definition
  fill_in('definition', :with => 'a procedure intended to establish the quality, \
                                  performance, or reliability of something, especially \
                                  before it is taken into widespread use')
end

def click_home_button
  click_on('homeButton')
end

def click_test_word
  click_link('test')
end

def click_edit_entry
  click_button('Edit Entry')
end

def expect_the_word_on_the_page
  expect(page).to(have_content('test'))
end

def expect_the_word_to_be_removed
  within("ul#word-list") do
    expect(page).not_to(have_content('test'))
  end
  expect(page).to(have_content('removed'))
end

def expect_the_definition_to_be_removed
  expect(page).not_to(have_content('procedure intended to establish the quality'))
end

def expect_the_definition_on_the_page
  expect(page).to(have_content('procedure intended to establish the quality'))
end
