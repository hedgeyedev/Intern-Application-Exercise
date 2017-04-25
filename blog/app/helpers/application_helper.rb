module ApplicationHelper

	#return cleanly formatted date
	def clean_date(date)
		( Time.at(Time.now).to_date == Time.at(date).to_date ) ? ( "Today" ) : ( date.strftime("%b %d, %Y") )
	end 

end
