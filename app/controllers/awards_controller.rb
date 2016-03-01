class AwardsController < ApplicationController
  def index
    @awards = Award.all.includes :reports
  end
end
