class RoomsController < ApplicationController
  before_action :set_available_users, only: [:new, :create]
  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  private
  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end

  def set_available_users
    @available_users = User.where.not(id: current_user.id).pluck(:name, :id)
  end
end
