ActiveAdmin.register Project do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

	permit_params :name, :content, :price, :image

	show do |t|
		attributes_table do
			row :name
			row :content
			row :price
			row :image do
				project.image? ? image_tag(project.image.url, height: '100') : content_tag(:span, 'No Photo Yet')
			end
		end
	end

	form :html => { :enctype => "multipart/form-data" } do |f|
		f.inputs do
			f.input :name
			f.input :content
			f.input :price
			f.input :image, hint: f.project.image? ? image_tag(project.image.url, height: '100') : content_tag(:span, 'Upload JPG/PNG/GIF image')
		end
		#submit button
		f.actions
	end

end
