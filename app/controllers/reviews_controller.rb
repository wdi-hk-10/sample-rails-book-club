class ReviewsController < ApplicationController
  before_action :set_book, only: [:new, :create, :edit]

  def new
    @review = @book.reviews.new
  end

  def create
    # This line works too but using review_params (it is a method!) 
    # is the new standard.
    #review = @book.reviews.new(content: review_params[:content])
    review = @book.reviews.new(review_params)
    review.user = @current_user
    review.save

    redirect_to main_path
  end

  def index
    # You can load the user first and let get the reviews and books later
    # @user = User.find(params[:user_id])

    # But if you use the .includes method, 
    # then it can load all reviews and books in one go
    @user = User.includes(:reviews, :books).find(params[:user_id])
    @reviews = @user.reviews
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    # This :update is actually a class method
    Review.update(params[:id], review_params)

    redirect_to user_reviews_path(@current_user)
  end

  def destroy
    # Let's just do hard delete for now
    # And yeah this :update is also a class method 
    Review.delete(params[:id])

    redirect_to user_reviews_path(@current_user)
  end

  private
    def set_book
      @book = Book.find(params[:book_id])
    end

    def review_params
      params.require(:review).permit(:content)
    end
end
