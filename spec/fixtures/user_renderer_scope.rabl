object @user => :user
attributes  :guid => :id
node(:full_name){ |user| full_name(user) }
node(:formatted_email){ |user| formatted_email(full_name(user), user.email) }
node(:password){ |user| hide_password(user.password) }
