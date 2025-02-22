class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
     @pet = Pet.create(params[:pet])
     if Owner.find_by_id(params["pet"]["owner_id"])
      @pet.owner = Owner.find_by_id(params["pet"]["owner_id"])
    else 
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
      redirect "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  # patch '/pets/:id' do 
  #   binding.pry
  #     ####### bug fix
  #     if !params[:pet].keys.include?("owner_id")
  #      params[:pet]["owner_id"] = []
  #      end
  #      #######
    
  #      @pet = Pet.find(params[:id])
  #      @pet.update(params["pet"])
  #      if !params["owner"]["name"].empty?
  #        @pet.owner << Owner.create(name: params["owner"]["name"])
  #      end
  #      redirect "pets/#{@pet.id}"
  # end

    patch '/pets/:id' do 
      binding.pry
      ####### bug fix
      if !params[:pet].keys.include?("owner_id")
       params[:pet]["owner_id"] = []
       end
       #######
    
       @pet = Pet.find(params[:id])
      #  @pet.update(params["pet"]["name"])
       @pet.name = params["pet"]["name"]
       if !params["owner"]["name"].empty?
        # @pet.owner.name = params["owner"]["name"]
        @pet.owner = Owner.create(name: params["owner"]["name"])
       else
        @pet.owner = Owner.find_by_id(params["pet"]["owner_id"])
        end
      @pet.save
       redirect "pets/#{@pet.id}"
  end


end