class AnalysisController < ApplicationController
  def answers
    render file: "public/index.html", layout: true
  end
end
