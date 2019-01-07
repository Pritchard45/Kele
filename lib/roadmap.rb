require 'httparty'
require 'json'

# current enrollment id 51963
# checkpoint_id random 2989
# chain id 7062

module Roadmap
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1/'

  def get_roadmap(chain_id)
    response = self.class.get(api_url("roadmaps/#{chain_id}"), headers: { :authorization => @auth_token })
    JSON.parse(response.body)

  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get(api_url("checkpoints/#{checkpoint_id}"), headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_remaining_checkpoints(chain_id)
    response = self.class.get(api_url("enrollment_chains/#{chain_id}/checkpoints_remaining_in_section"), headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end


  private

  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end
end
