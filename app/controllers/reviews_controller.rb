class ReviewsController < ApplicationController
  before_action :set_book, only: [:new, :create]

  def new
    @review = @book.reviews.new
  end

  def create
    #review = @book.reviews.new(content: review_params[:content])
    review = @book.reviews.new(review_params)
    review.user = @current_user
    review.save

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
