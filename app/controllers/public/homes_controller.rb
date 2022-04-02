class Public::HomesController < ApplicationController
  def top
     @items=Item.limit(4).order(:creatted_at)
  end

  def about
  end
end
