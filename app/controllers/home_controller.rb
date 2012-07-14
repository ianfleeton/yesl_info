class HomeController < ApplicationController
  def index
    @backups_pending = HostingAccount.where('backed_up_on < DATE_SUB(NOW(), INTERVAL backup_cycle DAY)').count
  end
  
  def passwords
    @passwords = Array.new
    10.times {@passwords << create_password}
  end
  
  private
  
  def create_password
    chars = %w{a b c d e f g h j k m n o p q r s t u v w x y z A B C D E F G H J K L M N P Q R S T U V W X Y Z 2 3 4 5 6 7 8 9}
    pw = ''
    10.times {pw += chars[rand(chars.length)]}
    pw
  end
end
