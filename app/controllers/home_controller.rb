class HomeController < ApplicationController
  def welcome
  end

  def main
    @books = []
    all_books = Book.all
    all_books.each_with_index do |book, i|
      if i % 3 == 0
        @books << [book]
      else
        @books[i/3] << book
      end
    end
  end
end
