class FiguresController < ApplicationController
  # add controller methods

  get '/figures' do
    @figures = Figure.all 
    erb :"figures/index"
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all 
    erb :"figures/new"
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    if !params["title"]["name"].empty?
      @figure.titles << Title.find_or_create_by(name: params["title"]["name"])
    end

    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.find_or_create_by(params["landmark"])
    end

    @figure.save 
    redirect "figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all 
    erb :"figures/edit"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  patch '/figures/:id' do

    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])

    if !params["landmark"].empty?
      @figure.landmarks << Landmark.create(params["landmark"])
    end

    if !params["title"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end

    redirect "figures/#{@figure.id}"
  end

end
