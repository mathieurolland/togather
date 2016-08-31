class PlaceMailer < ApplicationMailer
  def creation_confirmation(place)
    @place = place

    mail(
      to:       @place.user.email,
      subject:  "Place #{@place.name} created!"
    )
  end
end
