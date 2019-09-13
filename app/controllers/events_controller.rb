class EventsController < ApplicationController
  skip_before_action :require_login, :only => [:call, :summary, :dtfm]
  def call
    logger.debug(params)
    
  end

  def dtmf
  end

  def summary
  end
end
