class Word
  attr_reader(:name)

  def initialize(arguments)
    @name = arguments[:name]
  end
end
