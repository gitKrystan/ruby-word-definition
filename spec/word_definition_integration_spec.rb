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
end

def add_test_word
  visit('/')
  click_link('+')
  fill_in_test_word()
  click_button('Add')
end

def fill_in_test_word
  fill_in('word', :with => 'test')
end

def click_home_button
  click_on('homeButton')
end

def expect_the_word_on_the_page
  expect(page).to(have_content('test'))
end
