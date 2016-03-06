class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    Book.create(book_params)

    redirect_to main_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :url, :author, :isbn)
    end
end
