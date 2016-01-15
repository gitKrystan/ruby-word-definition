require('rspec')
require('word')
require('pry')

describe(Word) do
  describe('#initialize') do
    it('creates a new word object with an id') do
      test_word = a_new_word()
      expect(test_word.name()).to(eq('test'))
    end
  end
end

def a_new_word
  Word.new({:name => 'test'})
end
