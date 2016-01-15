require('sinatra')
require('sinatra/reloader')
require('pry')
require('./lib/word')
require('./lib/definition')

get('/') do
  @words = Word.all()
  @message = params[:message]
  erb(:index)
end

get('/words/new') do
  erb(:word_form)
end

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

    message = 'Your word has been added!'
    redirect("/words/#{id}?message=#{message}")
  else
    message = 'No word has been added!'
    redirect("/#{id}?message=#{message}")
  end
end

get('/words/:id') do
  id = params[:id]
  @word = Word.find(id)
  @definitions = @word.definitions()
  @message = params[:message]
  erb(:word)
end

post('/words/:id/change') do
  id = params[:id]
  @word = Word.find(id)
  @definitions = @word.definitions()

  option = params[:option]
  if option == "add definition"
    erb(:word_add_definition_form)
  elsif option == "remove word"
    message = "The word '#{@word.name()}' has been removed!"
    Word.remove(id)
    redirect("?message=#{message}")
  else
    redirect('/')
  end
end

post('/words/:id/success') do
  id = params[:id]
  word = Word.find(id)
  new_definition = params[:definition]

  if new_definition.length() > 0
    definition = Definition.new({:text => new_definition})
    word.add_definition(definition)

    message = 'Your definition has been added!'
  else
    message = 'No definition has been added!'
  end

  redirect("/words/#{id}?message=#{message}")
end
