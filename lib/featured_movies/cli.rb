class FeaturedMovies::CLI
  def call
    list_movies
    menu
    exit_message
  end

  def list_movies
    puts "Current featured movies on Newgrounds: "
    @movies = FeaturedMovies::Movie.current
    x = 0
    while x!=12
      puts "#{x+1}. Title: #{@movies.titles[x]} \n - Creator: #{@movies.creators[x]} \n"
      x= x+ 1
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the index of a movie for it's description, movies brings up the list again, exit to quit"
      input = gets.strip.downcase
      if input.to_i > 0
        puts "Genre: #{@movies.genres[input.to_i - 1]} \nDescription: #{@movies.descriptions[input.to_i - 1]} \nURL: #{@movies.urls[input.to_i - 1]}"
      elsif input == "movies"
        list_movies
      else
        if input == "exit"
        else
          puts "Invalid input. Enter movies to bring up the list again or exit to quit."
        end
      end
    end
  end

  def exit_message
    puts "Goodbye"
  end
end