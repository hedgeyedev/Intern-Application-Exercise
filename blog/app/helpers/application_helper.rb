module ApplicationHelper
  def format_date_time(date_time)
    date_time.strftime("%B #{date_time.day.ordinalize} %Y")
  end
end
