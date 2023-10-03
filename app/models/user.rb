class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :hits
  
    # Returns the hit count for the current month
    def exceeded_quota?
        self.hits_count >= 10000
      end
    
    def count_hits_in_user_timezone
        start = Time.now.in_time_zone('Australia/Sydney').beginning_of_month
        hits.where('created_at > ?', start).count
    end
    
  end
  