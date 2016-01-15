require('sinatra')
require('sinatra/reloader')
require('pry')
require('./lib/word')
require('./lib/definition')

get('/') do
  @words = Word.all()
  erb(:index)
end

get('/words/new') do
  erb(:word_form)
end

post('/words/success') do
  new_word = params[:word]
  word = Word.new({:name => new_word})
  word.save()
  id = word.id()

  new_definition = params[:definition]
  definition = Definition.new({:text => new_definition})
  word.add_definition(definition)

  message = 'Your word has been added!'
  redirect("/words/#{id}?message=#{message}")
end

get('/words/:id') do
  id = params[:id]
  @word = Word.find(id)
  @definitions = @word.definitions()
  @message = params[:message]
  erb(:word)
end
