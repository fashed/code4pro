class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:google_oauth2, :facebook]

  validates :name, presence: :true, length: {maximum: 25}

  has_many :subscriptions
  has_many :projects, through: :subscriptions

  #using self, dont have to create new instance of the user. can do User.find_for_google_oauth2(bla)
  #@user = User
  #then @user.find_for_google_oauth2(blah)

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
  	data = access_token.info
  	#if we cant find anyone with provider google and google uid, we need to check registered user
  	user = User.where(:provider => access_token.provider, :uid => access_token.uid).first

  	if user
  		return user
  	else
  		registered_user = User.where(:email => access_token.email).first
  		if registered_user
  			return registered_user
  		else
  			user = User.create(
  				name: data["name"],
  				provider: access_token.provider,
  				email: data["email"],
  				uid: access_token.uid,
  				password: Devise.friendly_token[0,20]
  			)
  		end
  	end
  end

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first

    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.name = auth.info.name
          user.provider = auth.provider
          user.uid = auth.uid
          user.email = auth.info.email
          user.image = auth.info.image
          user.password = Devise.friendly_token[0,20]
      end
    end
  end

end
