class ChatsController < ApplicationController


    def show
      @user = User.find(params[:id])
      rooms = current_user.user_rooms.pluck(:room_id)#カレントに紐付いた配列呼ぶ
      user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    
      unless user_rooms.nil?
        @room = user_rooms.room#空じゃない時に部屋番いれる
      else
        @room = Room.new#ない時インスタンスつくる
        @room.save
        UserRoom.create(user_id: current_user.id, room_id: @room.id)#user_roomに登録←自分
        UserRoom.create(user_id: @user.id, room_id: @room.id)#user_roomに登録←チャット相手
      end

      @chats = @room.chats
      @chat = Chat.new(room_id: @room.id)#for_with用
    end

    #chat作成
    def create
      @chat = current_user.chats.new(chat_params)
      @chat.save
    end
  
    private
    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end
     
end
