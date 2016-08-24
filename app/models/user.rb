class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:linkedin]
  has_many :hosted_guys, class_name: 'connection', foreign_key: 'host_id'
  has_many :invited_guys, class_name: 'connection', foreign_key: 'guest_id'
  has_many :meetings, through: :connections
  has_many :messages
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :places
  has_many :recommended_users

  # se mettre d'accord sur status : false = partner, true = user (ou l'inverse)

    def self.find_for_linkedin_oauth(auth)

    user_params = {
      uid: auth.uid,
      provider: auth.provider,
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      picture_url: auth.info.image,
      token: auth.credentials.token,
      token_expiry: Time.now + auth.extra.access_token.params[:oauth_expires_in].to_i.seconds
    }

    user = User.where(provider: auth.provider, uid: auth.uid).first
    user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

end
