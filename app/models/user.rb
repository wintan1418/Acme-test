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
    
      def count_hits
        user_time_zone = self.time_zone || 'UTC'  # default to UTC if not set
        start_of_month_in_user_time_zone = Time.now.in_time_zone(user_time_zone).beginning_of_month
        self.hits.where('created_at > ?', start_of_month_in_user_time_zone).count
      end
      
    
  end
  