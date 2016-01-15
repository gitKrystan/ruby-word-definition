require('rspec')
require('word')
require('pry')

describe(Word) do
  before() do
    Word.clear()
  end

  describe('#initialize') do
    it('creates a new word object with an id') do
      test_word = a_new_word()
      expect(test_word.name()).to(eq('test'))
      expect(test_word.id()).to(eq('1'))
    end
  end

  describe('#generate_id') do
    it('generates a unique id for each word') do
      first_word = a_first_word()
      test_word = a_new_word()
      expect(first_word.id()).to(eq('1'))
      expect(test_word.id()).to(eq('2'))
    end
  end
end

def a_new_word
  Word.new({:name => 'test'})
end

def a_first_word
  Word.new({:name => 'first'})
end
