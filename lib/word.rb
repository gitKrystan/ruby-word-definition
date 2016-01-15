class Word
  attr_reader(:name, :id, :definitions)

  @@last_id = 0
  @@words = []

  def initialize(arguments)
    @name = arguments[:name]
    @id = generate_id().to_s()
    @definitions = []
  end

  def generate_id
    @@last_id += 1
  end

  def save
    @@words << self
  end

  def add_definition(definition)
    @definitions << definition
  end

  def self.clear
    @@last_id = 0
    @@words = []
  end

  def self.all
    @@words
  end

  def self.find(identification)
    @@words.each() do |word|
      if word.id() == identification
        return word
      end
    end
  end

  def self.remove(identification)
    word_index = nil
    @@words.each() do |word|
      if word.id() == identification
        word_index = @@words.index(word)
        break
      end
    end
    @@words.delete_at(word_index)
  end
end
