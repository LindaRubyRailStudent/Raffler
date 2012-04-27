class Entry < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :maximum=>20, :message=>"cannot be longer than 20 characters"
end
