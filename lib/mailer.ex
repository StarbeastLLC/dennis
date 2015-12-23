defmodule Dennis.Mailer do

	@from "postmaster@sandbox9ddf700296ad4bf0a817cedfe2a09d99.mailgun.org"
	@to "guerrazuramx@gmail.com"

	use Mailgun.Client, 
		domain: Application.get_env(:dennis, :mailgun_domain),
		key: Application.get_env(:dennis, :mailgun_key)

	def send_invitation(subject, athlete, email, token, message, org_name) do
		send_email to: email,
			from: @from,
			subject: subject,
			html: Phoenix.View.render_to_string(Dennis.Admin.EmailView, "athlete-invite-email.html", athlete: athlete, email: email, token: token, message: message, org_name: org_name)
	end

	def send_invite_request(email) do
		send_email to: email, # mymiles
			from: @from,
			subject: "Invitation request from charity!",
			html: Phoenix.View.render_to_string(Dennis.Admin.EmailView, "request-invite-email.html", email: email)
	end

	def thank_donor(athlete, donor_email, challenge) do
		send_email to: donor_email,
			from: @from,
			subject: "Thanks for your donation!",
			html: Phoenix.View.render_to_string(Dennis.Admin.EmailView, "donor-invite-email.html", donor_email: donor_email, athlete: athlete, challenge: challenge)
	end


end