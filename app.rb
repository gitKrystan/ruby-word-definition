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
  @word = params[:word]
  @message = 'Your word has been added!'
  Word.new({:name => @word})
    .save()
  erb(:word)
end
