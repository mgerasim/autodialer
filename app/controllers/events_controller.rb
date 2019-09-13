require 'json'
class EventsController < ApplicationController
  skip_before_action :require_login, :only => [:call, :summary, :dtfm]
  skip_before_action :verify_authenticity_token

  def call
    
    logger.debug(params)

    json = JSON.parse(params[:json])

    if (json["call_state"] == 'Appeared') 

      telephone = json["from"]["number"]

      logger.debug(telephone)

      telephone = telephone.split(//).last(10).join("").to_s

      telephone = "9600531314"

      outgoing = Outgoing.where(:telephone => "7#{telephone}\n").first

      if (outgoing != nil)
        Answer.create(:contact => telephone, :level => 0, :trank => outgoing.trank)
      end

      logger.debug(telephone)

    end

  end

  def dtmf
  end

  def summary
  end
end
