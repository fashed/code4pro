module ApplicationHelper
	def avatar_url(user)
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase

		if user.image
			user.image
		elsif gravatar_id
			"https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=mm&s=40"
		end
	end

end
