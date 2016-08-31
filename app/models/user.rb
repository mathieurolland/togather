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

  has_attachment :photo, accept: [:jpg, :png]
  has_many :meetings, through: :connections
  has_many :messages
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :places
  has_many :recommended_users

  #after_create :send_welcome_email
  geocoded_by :work_place
  after_validation :geocode, if: :work_place_changed?


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

  # def send_welcome_email
  #   UserMailer.welcome(self).deliver_now
  # end

  def create_suggestions
    array = []
    self.invited_connections.each do |x|
      if x.status == "connected"
        x.host.invited_connections.each { |y| array << y.host if y.status == "connected" }
        x.host.hosted_connections.each { |y| array << y.guest if y.guest != self && y.status == "connected" }
      end
    end
    self.hosted_connections.each do |x|
      if x.status == "connected"
        x.guest.invited_connections.each { |y| array << y.host if y.host != self && y.status == "connected" &&  array.include?(y.host) == false }
        x.guest.hosted_connections.each { |y| array << y.guest if y.status == "connected" &&  array.include?(y.guest) == false }
      end
    end
    contacts = array.select do |value|
      (Connection.where(guest: self, host: value).first == nil || Connection.where(guest: self, host: value).first.status != "connected") && (Connection.where(guest: value, host: self).first == nil || Connection.where(guest: value, host: self).first.status != "connected")
    end
    contacts.each do |contact|
      invers_connection = Connection.where(guest: contact, host: self).first
      Connection.create(status: "suggested", guest: self, host: contact) if invers_connection == nil || invers_connection.status != "valid"
    end
  end

  def suggestions
    suggestions = []
    selec = ["suggested", "invited", "waiting", "valid"]
    self.invited_connections.each { |s| suggestions << s if selec.include?(s.status) }
    self.hosted_connections.each { |s| suggestions << s if s.status == "valid" }
    suggestions
  end

  def connected_data
    datas = []
    self.total_connection.each do |x|
      total_suggestion = User.find(x.host_id).total_connection + User.find(x.guest_id).total_connection
      total_suggestion.each { |y| datas << { from: y.guest_id, to: y.host_id} }
    end
    data_connection = []
    datas.each { |x| data_connection << x unless double_connection?(data_connection, x) }
    data_connection
  end

  def double_connection?(array, lien)
    array.include?({ from: lien[:to], to: lien[:from] }) || array.include?({ from: lien[:from], to: lien[:to] })
  end

  def total_connection
    self.invited_connections.where(status: "connected") + self.hosted_connections.where(status: "connected")
  end

  def total_connected
    self.total_connection.map { |c| [c.host, c.guest].select{ |user| user != self }.first}
  end

  def total_suggested
    self.suggestions.map { |c| [c.host, c.guest].select{ |user| user != self }.first}
  end

  def node_user
    nodes = [self.node(0)]
    self.total_connected.each do |connected|
      nodes << connected.node(1)
    end
    self.total_suggested.each do |suggested|
      nodes << suggested.node(2)
    end
    nodes
  end

  def node(group)
    { id: self.id,
      shape:'circularImage',
      image: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{self.photo.path}",
      brokenImage: "https://res.cloudinary.com/dxiikz0qq/image/upload/v1472566834/bdxotyef6ah4ym2qcjzz.png",
      label: "#{self.first_name} #{self.last_name}",
      group: group
    }
  end

  def count_meetings
    count = 0
    self.places.each { |place| count += place.meetings.count }
    count
  end
end
