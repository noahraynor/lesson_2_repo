WEAPONS = %w(rock paper scissors lizard spock)
WINS_NEEDED = 3
WINNING_COMBOS = {
  rock: %w(lizard scissors),
  paper: %w(rock spock),
  scissors: %w(paper lizard),
  lizard: %w(spock paper),
  spock: %w(scissors rock)
}

def prompt(message_string)
  puts "==> #{message_string}"
end

def read_weapon
  loop do
    prompt("Please choose your weapon - Rock, Paper, Scissors,"\
           " Lizard, or Spock.  \n    (You can use the full weapon name"\
           " or part of the name)")
    choice = gets.chomp.downcase
    if valid_weapon_choice?(choice)
      return convert_choice(choice)
    else
      prompt("Please enter a valid selection.")
      puts
    end
  end
end

def valid_weapon_choice?(choice)
  num_starting_with = WEAPONS.select do |weapon|
    weapon.start_with?(choice)
  end
  WEAPONS.include?(choice) || num_starting_with.length > 0 && choice.length > 0
end

def convert_choice(choice)
  starts_with_choice = WEAPONS.select do |weapon|
    weapon.start_with?(choice)
  end
  if starts_with_choice.length == 1
    starts_with_choice[0]
  else
    prompt("There are multiple weapons that start with '#{choice}'."\
           " Please enter more characters.")
    puts
    read_weapon
  end
end

def user_win?(user_weapon, computer_weapon)
  WINNING_COMBOS[user_weapon.to_sym].include?(computer_weapon)
end

def increment_wins(user_victory, user_win_count, computer_win_count)
  if user_victory
    user_win_count += 1
  else
    computer_win_count += 1
  end
  [user_win_count, computer_win_count]
end

def display_game_result(user_victory)
  case user_victory
  when true
    prompt("You are the winner!")
  when false
    prompt("The computer is the winner!")
  else
    prompt("The result is a tie!")
  end
end

def display_match_results(user_win_count)
  if user_win_count == 3
    prompt("You are the Grand Winner!")
  else
    prompt("The computer is the Grand Winner!")
  end
end

def match_over?(user_win_count, computer_win_count)
  user_win_count == WINS_NEEDED || computer_win_count == WINS_NEEDED
end

def play_again?
  loop do
    prompt("Do you want to play again? (y/n)")
    answer = gets.chomp.downcase
    if answer == 'n' || answer == 'y'
      return answer == 'y'
    else
      prompt("Please enter a valid response.")
    end
  end
end

prompt("Welcome to the Rock Paper Scissors Lizard Spock game!")
puts
prompt("This is a best of 5 match! The first to 3 victories wins!")
puts

# Main loop
loop do
  user_win_count = 0
  computer_win_count = 0

  loop do
    user_victory = nil
    user_weapon = read_weapon
    computer_weapon = WEAPONS.sample

    prompt("Your weapon is #{user_weapon.capitalize}")
    prompt("The computer's weapon is #{computer_weapon.capitalize}")

    unless user_weapon == computer_weapon
      user_victory = user_win?(user_weapon, computer_weapon)
      user_win_count, computer_win_count = increment_wins(user_victory,
                                                          user_win_count,
                                                          computer_win_count)
    end

    display_game_result(user_victory)

    prompt("User wins: #{user_win_count}")
    prompt("Computer wins: #{computer_win_count}")
    puts

    break if match_over?(user_win_count, computer_win_count)
  end

  display_match_results(user_win_count)

  break unless play_again?
  puts
end

puts
prompt("Thank you for playing.  Good bye!")
