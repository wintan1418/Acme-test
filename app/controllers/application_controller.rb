class ApplicationController < ActionController::API
    before_action :user_quota

    private
  
    def user_quota
      # Ensures that the current_user exists and then check its hits_count
      if current_user.exceeded_quota? || (Time.now.day == 1 && current_user.count_hits >= 10000)
        render json: { error: 'over quota' }
      end
    end
  
    end
  