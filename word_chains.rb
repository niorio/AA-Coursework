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


  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}

    explore_current_words(target)

    build_path(target)

  end

  def explore_current_words(target)

    until @current_words.empty?
      new_current_words = []

      @current_words.each do |current_word|
        adjacent_words(current_word).each do |adjacent|
          next if @all_seen_words.has_key?(adjacent)
          new_current_words << adjacent
          @all_seen_words[adjacent] = current_word
          return if adjacent == target
        end
      end

      @current_words = new_current_words
    end

  end


  def build_path(target)

    path = []
    position = target

    until position.nil?
      path << position
      position = @all_seen_words[position]
    end

    path
  end

end
