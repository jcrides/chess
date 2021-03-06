class User < ActiveRecord::Base
  has_many :games
  has_many :pieces

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


  scope :online, -> { where('updated_at >= ?', 10.minutes.ago) }


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      require 'debugger'; debugger
  		user.email = auth.info.email || ""
  		user.password = Devise.friendly_token[0, 20]
  	end
  end

  def self.email
    user.email = User.online
  end


end
