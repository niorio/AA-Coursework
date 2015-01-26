class WordChainer

  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp)
  end

  def adjacent_words(word)
    adjacents = []

    candidates = @dictionary.select{|dict_word| dict_word.length == word.length}

    candidates.each do |dict_word|
      letters_off = 0
      dict_word.each_char.with_index do |char, i|
        letters_off += 1 if char != word[i]
        break if letters_off > 1
      end
      adjacents << dict_word if letters_off == 1
    end

    adjacents

  end

end
