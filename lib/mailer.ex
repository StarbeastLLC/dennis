defmodule Dennis.Mailer do

	@from "postmaster@sandbox9ddf700296ad4bf0a817cedfe2a09d99.mailgun.org"
	@to "guerrazuramx@gmail.com"

	use Mailgun.Client, 
		domain: Application.get_env(:dennis, :mailgun_domain),
		key: Application.get_env(:dennis, :mailgun_key)

	def send_invitation(subject, user_name, email, token) do
		send_email to: email,
			from: @from,
			subject: subject,
			html: Phoenix.View.render_to_string(Dennis.Admin.EmailView, "athlete-invite-email.html", user_name: user_name, email: email, token: token)
	end

	def send_invite_request(email) do
		send_email to: email, # mymiles
			from: @from,
			subject: "Invitation request from charity!",
			html: Phoenix.View.render_to_string(Dennis.Admin.EmailView, "request-invite-email.html", email: email)
	end

	def send_donor_invitation(user) do
		send_email to: user.email,
			from: @from,
			subject: "Thanks for your donation!",
			html: Phoenix.View.render_to_string(Dennis.Admin.EmailView, "donor-invite-email.html", user: user)
	end


end