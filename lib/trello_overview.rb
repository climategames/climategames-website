require 'trello'

class TrelloOverview
  class PenguinCard

    attr_reader :card, :ticket_number

    def initialize(trello_card)
      @card = trello_card
      @ticket_number = self.class.extract_ticket_number(@card.name)
    end

    def numbers
      if @ticket_number
        @ticket_number.split(".").map(&:to_i)
      else
        [9999999]
      end
    end

    def name
      card.name
    end

    def url
      card.url
    end

    def list_id
      card.list_id
    end

    def column_name
      "-"
    end

    def <=>(other)
      ([numbers] + [card.last_activity_date]) <=> ([other.numbers] + [other.card.last_activity_date])
    end

    def to_s
      "%6s | %s" % [ticket_number, name]
    end

    private

    def self.extract_ticket_number(name)
      number = if name =~ /^PP-?(\d+(?:\.\d+)*) /
                 $1.strip
               else
                 nil
               end
    end
  end

  attr_reader :board, :cards, :lists, :highest_ticket_number

  def initialize
    @board = Trello::Board.find("55094a5b8bf38d05e7731665")
    @cards = board.cards.map { |c| PenguinCard.new(c) }
    @highest_ticket_number = @cards.select { |c| c.ticket_number }.sort.last.ticket_number
    @lists = @board.lists
  end
end


