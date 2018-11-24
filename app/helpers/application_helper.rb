module ApplicationHelper

  def exclusive_use_message(current_user)
    "#{current_user.full_name} accessed at #{Time.zone.now.strftime('%H:%M %Y-%m-%d %Z')}."
  end

end
