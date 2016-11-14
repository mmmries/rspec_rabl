class RendererScopeHelper
  def self.full_name(user)
    [user.first_name, user.last_name].join(" ")
  end

  def self.formatted_email(name, email)
    "\"#{name}\" <#{email}>"
  end

  def self.hide_password(password)
    "*" * password.length
  end
end
