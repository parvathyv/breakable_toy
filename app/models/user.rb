class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locations, through: :hunts

  has_many :hunts, class_name: "Hunt"
  has_many :huntsplayeduser, class_name: "Huntsplayeduser"


  devise :omniauthable, :omniauth_providers => [:github]
  mount_uploader :profile_photo, ProfilePhotoUploader

  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    user.avatar_url = auth.info.avatar_url # assuming the user model has an image
   end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
