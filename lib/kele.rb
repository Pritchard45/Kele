require 'httparty'
require 'json'
require './lib/roadmap'


class Kele
  include HTTParty
  include Roadmap
  base_uri 'https://www.bloc.io/api/v1/'


  def initialize(email, password)
    response = self.class.post(api_url("sessions"), body: { email: email, password: password })
    raise 'Invalid email or password' if response.code == 404
    @auth_token = response["auth_token"]

  end

  def get_me
    response = self.class.get(api_url("users/me"), headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

    # mentor_id = 2292457
  def get_mentor_availability(mentor_id)
    response = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    JSON.parse(response.body).to_a
  end



# current enrollment id 51963
# checkpoint_id random 2989
# chain id 7062
  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
