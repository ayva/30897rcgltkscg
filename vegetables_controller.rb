class VegetablesController < ApplicationController

  def index
    @vegetables = Vegetable.all #was plural, our Obj is Vegetable

  end

  def show
    @vegetable = Vegetable.find(params[:id])
  end

  def new
    @vegetable = Vegetable.new
    redirect_to vegetables_path
    #added redirection to show all vegetables after creation, we also could keep it showing a newly created veg
  end

  def create
    @vegetable = Vegetable.new(whitelisted_vegetable_params)
    if @vegetable.save
      flash[:success] = "That sounds like a tasty vegetable!"
      redirect_to vegetables_path(@vegetable)
      #path fixed, can't redirect  to instance
    else
      render :new
      #we need render method here because we didn't save and don't have params
      #need else statement to exclude rendering both pages
    end
    
  end

  def edit
    @vegetable = Vegetable.find(params[:id])
    #to find veg we need id
  end

  def update
    @vegetable = Vegetable.find(params[:id])
    #to find veg we need id
    if @vegetable.update(whitelisted_vegetable_params)
      #update needs params to update info
      flash[:success] = "A new twist on an old favorite!"
      redirect_to vegetables_path
      #we need a path here instead of instance to make it work

    else
      flash[:error] = "Something is rotten here..."
      render :edit
    end
  end

  def destroy
    #rails call it destroy, not delete method
    @vegetable = Vegetable.find(params[:id])
    @vegetable.destroy
    flash[:success] = "That veggie is trashed."
    redirect_to vegetables_path
    #same problem with path
  end

  private

  def whitelisted_vegetable_params
    params.require(:vegetable).permit(:name, :color, :rating, :latin_name)
    #params.require needed to make it pass params
  end


end
