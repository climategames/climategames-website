module Admin
  class TrelloCardsController < ApplicationController
    before_filter :authenticate_refinery_user!

    def index
      @trello_overview = TrelloOverview.new
      @board = @trello_overview.board
      @cards = @trello_overview.cards.sort
      @lists = @trello_overview.lists
      @list_lookup = {}
      @lists.each do |list|
        @list_lookup[list.id] = list
      end
    end

    private

    def authenticate_refinery_user!
      unless current_refinery_user
        error_404
      end
    end
  end
end

