class LikesController < ApplicationController
  before_action :set_dog

  def create
    if @dog.liked?(current_user)
      flash[:notice] = "You have already liked this dog"
    else
      @dog.likes.create(user_id: current_user.id)
    end
    redirect_to dog_path(@dog)
  end

  private

    def set_dog
      @dog = Dog.find(params[:dog_id])
    end
end
