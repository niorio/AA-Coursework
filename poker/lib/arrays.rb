class Array

  def my_uniq
    unique =[]
    self.each do |el|
      unique << el unless unique.include?(el)
    end
    unique
  end

  def two_sum
    result = []
    self.each_with_index do |first_num, i|
      self.each_with_index do |second_num, j|
        next if i >= j
        result<< [i,j] if first_num + second_num == 0
      end
    end
    result
  end

end

def my_transpose(array)
  array.transpose
end

def stock_picker(stock_prices)
  best_profit = 0
  answer = []

  stock_prices.each_with_index do |buy, i|
    stock_prices.each_with_index do |sell, j|
      next if i >= j
      if sell - buy > best_profit
        answer = [i,j]
        best_profit = sell - buy
      end
    end
  end

  answer
      
end
