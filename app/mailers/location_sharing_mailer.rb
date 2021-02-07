class LocationSharingMailer < ApplicationMailer
  def location_shared(location_shared_id)
    @shared_location = SharedLocation.find(location_shared_id)
    @recipient = @shared_location.user
    mail to: @recipient.email, subject: I18n.t("mailer.location.shared")
  end
end
