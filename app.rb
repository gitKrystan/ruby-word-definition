require('sinatra')
require('sinatra/reloader')
require('pry')
require('./lib/word')
require('./lib/definition')

get('/') do
  @words = Word.all().sort_by { |word| word.name().downcase() }
  @message = params[:message]
  erb(:index)
end

# Displays form to create a new word
get('/words/new') do
  erb(:word_form)
end

# Creates new word/definition objects for fields that have been filled in.
post('/words/success') do
  new_word = params[:word]
  new_definition = params[:definition]

  if new_word.length() > 0
    word = Word.new({:name => new_word})
    word.save()
    id = word.id()

    if new_definition.length() > 0
      definition = Definition.new({:text => new_definition})
      word.add_definition(definition)
    end

    @message = 'Your word has been added!'
    erb(:status)
  else
    @message = 'No word has been added!'
    erb(:status)
  end
end

# Displays information about a word
get('/words/:id') do
  id = params[:id]
  @word = Word.find(id)
  @definitions = @word.definitions()
  @message = params[:message]
  erb(:word)
end

# Gets input from the button group at the bottom of a word page and redirects to
# appropriate page
get('/words/:id/change') do
  id = params[:id]
  @word = Word.find(id)
  @definitions = @word.definitions()

  option = params[:option]
  if option == "edit entry"
    erb(:word_add_definition_form)
  elsif option == "remove word"
    @message = "The word '#{@word.name()}' has been removed!"
    Word.remove(id)
    erb(:status)
  else
    redirect to('/')
  end
end

# Adds a new definition if one has been input
post('/words/:id/success') do
  id = params[:id]
  word = Word.find(id)
  new_definition = params[:definition]

  if new_definition.length() > 0
    definition = Definition.new({:text => new_definition})
    word.add_definition(definition)

    @message = 'Your definition has been added!'
  else
    @message = 'No definition has been added!'
  end

  erb(:status)
end
