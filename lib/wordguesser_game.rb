class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  
  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(guess_letter)
    raise ArgumentError if guess_letter.nil?
    raise ArgumentError unless guess_letter =~ /[a-zA-Z]/
    raise ArgumentError if guess_letter.empty?
    guess_letter = guess_letter.downcase

    if @guesses.include?(guess_letter) || @wrong_guesses.include?(guess_letter)
      return false
    end

    if @word.include?(guess_letter)
      @guesses += guess_letter
    else
      @wrong_guesses += guess_letter
    end

    true
    
  end

  def word_with_guesses
    result = ""
    @word.chars.each do |test_char|
      if @guesses.include?(test_char)
        result << test_char
      else
        result << "-"
      end
    end
    result
  end

  def check_win_or_lose
    if @word == word_with_guesses
      return :win 
    else
      if @wrong_guesses.length >= 7
        return :lose
      else
        return :play
      end
    end
  end


  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
