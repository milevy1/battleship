class Game
  attr_reader :message, :player_board, :computer_board

  def initialize
    @message = Messages.new
    @player_board = nil
    @computer_board = nil
  end

  def main_menu
    @message.main_menu
    @message.prompt_user
    play_input = gets.chomp.downcase
    if play_input == "p"
      setup_game
    elsif play_input == "q"
      # Quits game
    else
      puts "Invalid input, please try again."
      main_menu
    end
  end

  def setup_game

  end

end
