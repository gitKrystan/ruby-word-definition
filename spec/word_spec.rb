require('rspec')
require('word')
require('definition')
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

  describe('#save') do
    it('adds a word to the array of saved words') do
      test_word = a_new_word()
      test_word.save()
      expect(Word.all()).to(eq([test_word]))
    end
  end

  describe('#add_definition') do
    it('adds a new definition to a word') do
      test_word = a_new_word()
      test_definition = a_new_definition()
      test_word.add_definition(test_definition)
      expect(test_word.definitions()).to(eq([test_definition]))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Word.all()).to(eq([]))
    end
  end

  describe('.clear') do
    it('empties out all fo the saved words') do
      a_new_word().save()
      Word.clear()
      expect(Word.all()).to(eq([]))
    end
  end

  describe('.find') do
    it('returns a word by its id number') do
      first_word = a_first_word()
      first_word.save()
      test_word = a_new_word()
      test_word.save()
      id_of_test_word = test_word.id()
      expect(Word.find(id_of_test_word)).to(eq(test_word))
    end
  end

  describe('.remove') do
    it('removes a word from the array of words') do
      first_word = a_first_word()
      first_word.save()
      test_word = a_new_word()
      test_word.save()
      id_of_test_word = test_word.id()
      Word.remove(id_of_test_word)
      expect(Word.all()).to(eq([first_word]))
    end
  end
end

def a_new_word
  Word.new({:name => 'test'})
end

def a_first_word
  Word.new({:name => 'first'})
end

def a_new_definition
  Definition.new({:text => 'a procedure intended to establish the quality, \
                            performance, or reliability of something, especially \
                            before it is taken into widespread use'})
end
