module InvitationsHelper

	def invitee_name(invitee_id)
		User.find(invitee_id).name
	end

	def invitee(invitee_id)
		User.find(invitee_id)
	end
end
