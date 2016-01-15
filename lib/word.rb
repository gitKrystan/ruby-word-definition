class Word
  attr_reader(:name, :id)

  @@last_id = 0
  @@words = []

  def initialize(arguments)
    @name = arguments[:name]
    @id = generate_id().to_s()
  end

  def generate_id
    @@last_id += 1
  end

  def save
    @@words << self
  end

  def self.clear
    @@last_id = 0
    @@words = []
  end

  def self.all
    @@words
  end
end
