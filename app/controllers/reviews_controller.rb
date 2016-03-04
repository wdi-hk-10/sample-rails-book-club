class ReviewsController < ApplicationController
  before_action :set_book, only: [:new, :create]

  def new
    @review = @book.reviews.new
  end

  def create
    #@book.reviews.create(content: review_params[:content])
    @book.reviews.create(review_params)

    redirect_to main_path
  end

  private
    def set_book
      @book = Book.find(params[:book_id])
    end

    def review_params
      params.require(:review).permit(:content)
    end
end
