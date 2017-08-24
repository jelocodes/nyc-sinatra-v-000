class FiguresController < ApplicationController
  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    title = Title.create(name: params["title"]["name"])
    figure = Figure.create(params["figure"])
    Landmark.create(name: params["landmark"]["name"], figure_id: figure.id)
    FigureTitle.create(title_id: title.id, figure_id: figure.id)
    figure.save
    redirect to '/figures'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    title = Title.create(name: params["title"]["name"])
    @figure.update(params["figure"])
    Landmark.create(name: params["landmark"]["name"], figure_id: figure.id)
    FigureTitle.create(title_id: title.id, figure_id: figure.id)
    redirect to "/figures/#{@figure.id}"
  end

end
