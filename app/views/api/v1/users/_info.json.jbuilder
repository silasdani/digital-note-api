json.id user.id
json.email user.email
json.name user.full_name
json.username user.username
json.first_name user.first_name
json.last_name user.last_name
json.phone_no user.phone_no
json.address user.address
json.uid user.uid
json.provider user.provider
json.created_at user.created_at
json.updated_at user.updated_at
json.profile_pic url_for(user.profile_pic) if user.profile_pic.attached?
