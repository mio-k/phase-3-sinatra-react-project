class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get "/dogs" do
    dogs = Dog.all.order(:name)
    dogs.to_json(include: [:orders])
  end

  get "/dogs/:dog_id" do
    dog = Dog.find(params[:dog_id])
    dog.to_json(include: [:orders])
  end

  delete "/dogs/:dog_id" do
    dog = Dog.find(params[:dog_id])
    dog.destroy
  end

  post "/dogs" do
    dog = Dog.create(name: params[:name], breed: params[:breed], age: params[:age], weight: params[:weight])
    dog.to_json
  end
  
  get "/orders" do
    orders = Order.all.order(:pickup_date)
    orders.to_json
  end

  get "/orders/:order_id" do
    order = Order.find(params[:order_id])
    dog = order.dog
    order.to_json(include: [:dog])
  end

  post "/orders" do
    order = Order.create(dog_id: params[:dog_id], item: params[:item], quantity: params[:quantity], pickup_date: params[:pickup_date])
    dog = order.dog
    dog.to_json
    order.to_json
  end

  patch "/orders/:order_id" do
    order = Order.find(params[:order_id])
    order.update(item: params[:item], quantity: params[:quantity], pickup_date: params[:pickup_date] )
    dog = order.dog
    dog.to_json
    order.to_json
  end

  delete "/orders/:order_id" do
    order = Order.find(params[:order_id])
    dog = order.dog
    dog.to_json
    order.destroy
  end

end
