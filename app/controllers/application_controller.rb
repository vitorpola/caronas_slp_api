class ApplicationController < ActionController::API

    # Enable CORS for API calls
    before_action :cors_preflight_check, :check_token
    after_action :cors_set_access_control_headers

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
      headers['Access-Control-Max-Age'] = "1728000"
    end

    def check_token
      if request.headers.include?('Authorization')
        @current_user = User.find_by(token: request.headers['Authorization'])
      end
    end 

    def cors_preflight_check
      if request.method == 'OPTIONS'
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token, Authorization, Content-Type'
        headers['Access-Control-Max-Age'] = '1728000'

        render text: '', content_type: 'text/plain'
      end
    end

    def handle_options_request
      render :text => '', :content_type => 'text/plain'
    end

    def send_push_notification(user, message)
      puts user.to_json
      if user
        gcm = GCM.new('AAAAzSNi7bQ:APA91bEdCTHJSZKXT_fXardrXpnYqd23-sWJml8An3_CnQ9N0q1dP21YgAkIuVomUnJEkLqURc3kQ_d-IKkZE9jLr8Z0yl4EqrJICVJm3z0lKgVx_KAeuO84QJSi8_a_C0_kUJuYnk7j')
        registration_ids= user.devices.map{ |dev| dev.token }
        options = {data: {message: message}, collapse_key: "do_not_collapse"}
        response = gcm.send(registration_ids, options)
      end
    end
end
