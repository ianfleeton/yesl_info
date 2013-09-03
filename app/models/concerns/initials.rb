module Initials
  extend ActiveSupport::Concern

  def initials
    name.each_char.select {|c| "ABCDEFGHIJKLMNOPQRSTUVWXYZ".include? c }.join
  end
end
