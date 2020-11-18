class CommentsChannel < ApplicationCable::Channel
  def subscribed
    @item = Item.find(params[:item_id])
    stream_from "item_comment"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end