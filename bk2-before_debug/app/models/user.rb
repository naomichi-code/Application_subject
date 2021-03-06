class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
      devise :database_authenticatable, :registerable,
             :recoverable, :rememberable, :validatable
  
      has_many :books, dependent: :destroy
      has_many :favorites, dependent: :destroy
      has_many :book_comments, dependent: :destroy
      #チャット機能
      has_many :chats
      has_many :user_rooms
      has_many :rooms, through: :user_rooms
      attachment :profile_image
    #フォロー機能
    has_many :relationships #has_many :relationships, foreign_key: 'user_id'と一緒の意味
    has_many :followings, through: :relationships, source: :follow #フォローしているユーザー達を取得
    has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id' #フォローされているユーザー達を取得
    has_many :followers, through: :reverse_of_relationships, source: :user
  
  
      #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
      validates :name, presence: true
      validates :name, length: {maximum: 20, minimum: 2}
      validates :introduction,length:{maximum: 50}
  
    def follow(other_user)
      unless self == other_user
        self.relationships.find_or_create_by(follow_id: other_user.id)
      end
    end

    def unfollow(other_user)
      relationship = self.relationships.find_by(follow_id: other_user.id)
      relationship.destroy if relationship
    end
  
    def following?(other_user)
      self.followings.include?(other_user)
    end
  
  
    def self.search(search,word)
          if search == "forward_match"
                            @user = User.where("name LIKE?","#{word}%")
          elsif search == "backward_match"
                            @user = User.where("name LIKE?","%#{word}")
          elsif search == "perfect_match"
                            @user = User.where("#{word}")
          elsif search == "partial_match"
                            @user = User.where("name LIKE?","%#{word}%")  
          else
                            @user = User.all
        end
    end
  
  
  
    #住所機能
  
    include JpPrefecture
    jp_prefecture :prefecture_code
  
    def prefecture_name
      JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
    end
  
    def prefecture_name=(prefecture_name)
      self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
    end
  
  #geocoder
  
    geocoded_by :postal_code
    after_validation :geocode, if: :postal_code_changed?
  
  
  
end

