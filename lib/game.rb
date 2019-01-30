class Game
  attr_reader :message

  def initialize
    @message = Messages.new
  end

  def main_menu
    @message.main_menu
    @message.prompt_user
  end

end
