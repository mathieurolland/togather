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
      invers_connection = Connection.where(guest: contact, host: self).first
      if invers_connection == nil || invers_connection.status != "valid"
        Connection.create(status: "suggested", guest: self, host: contact)
      end
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
    self.invited_connections.where(status: "connected").each do |x|
      datas << { from: x.host_id,
                  to: self.id}
      User.find(x.host_id).invited_connections.where(status: "connected").each do |y|
        datas << { from: y.host_id,
                  to: y.guest_id}
                end
      User.find(x.host_id).hosted_connections.where(status: "connected").each do |y|
        datas << { from: y.guest_id,
                  to: y.host_id}
                end
    end
    self.hosted_connections.where(status: "connected").each do |x|
    datas << { from: self.id,
                to: x.guest_id}
      User.find(x.guest_id).invited_connections.where(status: "connected").each do |y|
        datas << { from: y.host_id,
                  to: y.guest_id}
                end
      User.find(x.guest_id).hosted_connections.where(status: "connected").each do |y|
        datas << { from: y.guest_id,
                  to: y.host_id}
            end
    end
    data_connection = []
    datas.each do |x|
      # y = { from: x[:to], to: x[:from] }
      unless data_connection.include?({ from: x[:to], to: x[:from] })
        data_connection << x
      end
    end
    data_connection
  end



  def node_user
    nodeconnected = []
    nodesuggested = []
    nodeconnected << { id: self.id, shape:'circularImage', image: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{self.photo.path}",  brokenImage: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{self.photo.path}", label: "#{self.first_name} #{self.last_name}" }
    self.invited_connections.where(status: "connected").each do |x|
      nodeconnected << { id: x.host_id, shape:'circularImage', image: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x.host_id).photo.path}",  brokenImage: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x.host_id).photo.path}", group: 1, label: "#{User.find(x.host_id).first_name} #{User.find(x.host_id).last_name}" }
    end
        nodeconnected.each do |y|
        User.find(y[:id]).invited_connections.where(status: "connected").each do |x|
        nodesuggested << { id: x.host_id, shape:'circularImage', image: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x.host_id).photo.path}", brokenImage: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x.host_id).photo.path}", group: 2, label: "#{User.find(x.host_id).first_name} #{User.find(x.host_id).last_name}" }
      end
        User.find(y[:id]).hosted_connections.where(status: "connected").each do |x|
        nodesuggested << { id: x.guest_id, shape:'circularImage', image: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x.guest_id).photo.path}", brokenImage: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x.host_id).photo.path}", group: 2, label: "#{User.find(x.guest_id).first_name} #{User.find(x.guest_id).last_name}" }
      end
    end
    self.hosted_connections.where(status: "connected").each do |x|
      nodeconnected << { id: x.guest_id, shape:'circularImage', image: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x.guest_id).photo.path}",  brokenImage: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x.guest_id).photo.path}", group: 1, label: "#{User.find(x.guest_id).first_name} #{User.find(x.guest_id).last_name}" }
    end
      nodeconnected.each do |y|
        User.find(y[:id]).invited_connections.where(status: "connected").each do |x|
        nodesuggested << { id: x.host_id, shape:'circularImage', image: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x.host_id).photo.path}", group: 2, brokenImage: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x.guest_id).photo.path}", label: "#{User.find(x.host_id).first_name} #{User.find(x.host_id).last_name}" }
      end
        User.find(y[:id]).hosted_connections.where(status: "connected").each do |x|
        nodesuggested << { id: x.guest_id, shape:'circularImage', image: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x.guest_id).photo.path}", group: 2, brokenImage: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x.guest_id).photo.path}", label: "#{User.find(x.guest_id).first_name} #{User.find(x.guest_id).last_name}" }
      end
    end
    node_us = nodesuggested + nodeconnected
    b =nodeconnected.map{ |h| h[:id]}.uniq
    c = nodesuggested.map{ |h| h[:id]}.uniq
    node = []
    b.each do |x|
      node << { id: x, shape:'circularImage', image: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x).photo.path}", brokenImage: "https://res.cloudinary.com/dxiikz0qq/image/upload/v1472566834/bdxotyef6ah4ym2qcjzz.png", label: "#{User.find(x).first_name} #{User.find(x).last_name}", group: 1 }
    end
     c.each do |x|
      unless node.include?({ id: x, shape:'circularImage', image: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x).photo.path}", brokenImage: "https://res.cloudinary.com/dxiikz0qq/image/upload/v1472566834/bdxotyef6ah4ym2qcjzz.png", label: "#{User.find(x).first_name} #{User.find(x).last_name}", group: 1 })
      node << { id: x, shape:'circularImage', image: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{User.find(x).photo.path}", brokenImage: "https://res.cloudinary.com/dxiikz0qq/image/upload/v1472566834/bdxotyef6ah4ym2qcjzz.png", label: "#{User.find(x).first_name} #{User.find(x).last_name}", group: 2 }
      end
    end
    node - [{ id: self.id, shape:'circularImage', image: "http://res.cloudinary.com/dxiikz0qq/image/upload/t_media_lib_thumb/#{self.photo.path}", brokenImage: "https://res.cloudinary.com/dxiikz0qq/image/upload/v1472566834/bdxotyef6ah4ym2qcjzz.png", label: "#{self.first_name} #{self.last_name}", group: 1 }] + [{ id: self.id, shape:'circularImage', image: "http://res.cloudinary.com/dxiikz0qq/image/upload/#{self.photo.path}", label: "#{self.first_name} #{self.last_name}", group: 0 }]
  end

  def count_meetings
    count = 0
    self.places.each { |place| count += place.meetings.count }
    count
  end
end
