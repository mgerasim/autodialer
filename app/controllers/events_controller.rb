require 'json'
class EventsController < ApplicationController
  skip_before_action :require_login, :only => [:call, :summary, :dtfm]
  skip_before_action :verify_authenticity_token

  def call
    
    logger.debug(params)

    json = JSON.parse(params)

    if (json["call_state"] == 'Appeared') 

      telephone = json["from"]["number"]

      logger.debug(telephone)

      telephone = telephone.split(//).last(10).to_s

      logger.debug(telephone)

    end

  end

  def dtmf
  end

  def summary
  end
end
