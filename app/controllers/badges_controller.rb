class BadgesController < ApplicationController

  def index
    @badges = Badge.all
  end
end
