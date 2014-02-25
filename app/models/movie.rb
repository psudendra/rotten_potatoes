class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  #allows check boxes to sorted

  def self.ratings		#index.html.haml sets up checkboxes and makes them selectable
		{'G'=>'1','PG'=>'1','PG-13'=>'1','R'=>'1'}
	end
  def self.sort_by(rate, field)
  		return Movie.where({:rating => rate.keys}).order(field)
  	end
end