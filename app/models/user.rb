require 'digest/sha1'
class User < ActiveRecord::Base
  acts_as_agent :authentication => [ :login_and_password ],
                :activation => true

  has_one :profile
  
  has_many :participants
  has_and_belongs_to_many :events 
  has_and_belongs_to_many :machines 
  
  attr_accessible :email2, :email3, :superuser, :disabled

  def self.authenticate_with_login_and_password(login, password)
    u = find_by_login(login) # need to get the salt
    unless u
      u = find_by_email(login)
      unless u
        u = find_by_email2(login)
        unless u
          u = find_by_email3(login)
        end
      end
    end
    u && u.password_authenticated?(password) ? u : nil
  end
  
   #callback that replace empty strings in email2 and email3 for NULL
   def before_save
     if self.email2==""
       self.email2 = nil
     end
     if self.email3==""
       self.email3 = nil
     end
   end
end
