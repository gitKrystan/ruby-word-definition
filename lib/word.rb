class Word
  attr_reader(:name, :id)

  @@last_id = 0

  def initialize(arguments)
    @name = arguments[:name]
    @id = generate_id().to_s()
  end

  def generate_id
    @@last_id += 1
  end

  def self.clear
    @@last_id = 0
  end
end
