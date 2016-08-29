class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:linkedin]
  has_many :hosted_connections, foreign_key: :host_id, class_name: "Connection"
  has_many :invited_connections, foreign_key: :guest_id, class_name: "Connection"
  has_many :hosting_guys, through: :hosted_connections, class_name: "User", source: :host
  has_many :invited_guys, through: :invited_connections, class_name: "User", source: :guest

  has_attachment :photo
  has_many :meetings, through: :connections
  has_many :messages
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :places
  has_many :recommended_users

  # se mettre d'accord sur status : true = partner, false = user

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


  def create_suggestions
    array = []
    self.invited_connections.each do |x|
      if x.status == "connected"
        x.host.invited_connections.each do |y|
          if y.status == "connected"
            array << y.host
          end
        end
        x.host.hosted_connections.each do |y|
          if y.guest != self && y.status == "connected"
            array << y.guest
          end
        end
      end
    end
    self.hosted_connections.each do |x|
      if x.status == "connected"
        x.guest.invited_connections.each do |y|
          if  y.host != self && y.status == "connected" &&  array.include?(y.host) == false
            array << y.host
          end
        end
        x.guest.hosted_connections.each do |y|
          if  y.status == "connected" &&  array.include?(y.guest) == false
            array << y.guest
          end
        end
      end
    end
    contacts = array.select do |value|
      (Connection.where(guest: self, host: value).first == nil || Connection.where(guest: self, host: value).first.status != "connected") && (Connection.where(guest: value, host: self).first == nil || Connection.where(guest: value, host: self).first.status != "connected")
    end
    contacts.each do |contact|
      Connection.create(status: "suggested", guest: self, host: contact)
    end
  end

  def suggestions
    suggestions = []
    selection = ["suggested", "invited", "waiting", "valid"]
    self.invited_connections.each do |suggested|
      suggestions << suggested if selection.include?(suggested.status)
    end
    suggestions
  end

  def connected_data
    data_connection = []
    self.invited_connections.where(status: "connected").each do |x|
    data_connection << { from: x.host_id,
                to: self.id}
    end
    self.hosted_connections.where(status: "connected").each do |x|
    data_connection << { from: self.id,
                to: x.guest_id}
    end
    data_connection
  end

  def node_user
    node = []
    node << { id: self.id, label: "#{self.first_name} #{self.last_name}" }
    self.invited_connections.where(status: "connected").each do |x|
      node << { id: x.host_id, label: "#{User.find(x.host_id).first_name} #{User.find(x.host_id).last_name}" }
    end
   self.hosted_connections.where(status: "connected").each do |x|
      node << { id: x.guest_id, label: "#{User.find(x.guest_id).first_name} #{User.find(x.guest_id).last_name}" }
    end
    node
  end

end
