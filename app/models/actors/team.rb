class Team < ActiveRecord::Base

  has_many :users

=begin
1) Teams have many users
2) Teams require a program_starts_at datetime greater than its creation time
3) The program_starts_at used when creating the model must be converted into the beginning of the week, i.e input_value.beginning_of_week
=end

end