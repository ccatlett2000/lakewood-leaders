module ApplicationHelper
  def logged_in
    session[:user_id] && User.find_by_id(session[:user_id])
  end

  def current_user
    session[:user_id] && User.find_by_id(session[:user_id])
  end

  def format_time(time)
    time.strftime('%b %d, %Y %I:%M %p')
  end

  def rank_title(rank)
    titles = ["Non-Member", "Member", "Officer", "Advisor"]
    titles[rank]
  end
end
