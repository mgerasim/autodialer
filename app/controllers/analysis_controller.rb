class AnalysisController < ApplicationController
  def answers
    render file: "public/index2.html", layout: false
  end
end
