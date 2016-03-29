class MyMailer < ActionMailer::Base
	default from: 'hello@code4pro.com'

	def new_receipt(user, project)
		@user = user
		@project = project
		mail(to: @user.email, subject: 'Your receipt for Code4Pro')
	end
end