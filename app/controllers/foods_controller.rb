class FoodsController < ApplicationController
  def index
    if params[:letter].nil?
      @foods = Food.all
    elsif
      @foods = Food.by_letter(params[:letter])
    end
  end

  def show
    @food = Food.find_by(id: params[:id])
  end

  def new
    @food = Food.new
  end

  def edit
    @food = Food.find_by(id: params[:id])
  end

  def create
    @food = Food.create(food_params)

    if @food.save
      redirect_to food_path(@food)
    elsif
      render :new
    end
  end

  def update
    @food = Food.find_by(id: params[:id])
    @food.update(params.require(:food).permit(:name))
    
    if @food.save
      redirect_to food_path(@food)
    elsif
      render :edit, status: 422
    end
  end

  def destroy
    @food = Food.find_by(id: params[:id])

    if @food.destroy
      redirect_to("/foods")
    end
  end
  
  private
    # Only allow a list of trusted parameters through.
    def food_params
      params.require(:food).permit(:name, :description, :price, :category_id)
    end
end
