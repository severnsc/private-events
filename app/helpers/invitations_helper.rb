module InvitationsHelper

	def all_invitations(user)
		event_invites = user.invitations
		user.events.each do |event|
			event_invites += event.invitations
		end
		event_invites
	end

	def invitee_name(invitee_id)
		User.find(invitee_id).name
	end

	def invitee(invitee_id)
		User.find(invitee_id)
	end
end
