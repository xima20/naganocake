class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: [:edit, :update]
    def create
     @book = Book.new(book_params)
     @book.user_id = current_user.id
     if @book.save
     flash[:notice] = 'successfully'
     redirect_to book_path(@book)
   else
    flash[:notice] = 'error'
     redirect_to books_path
   end
   
    end
    def index
    	 @book = Book.new
    	 @books = Book.all
    end
    def show
    	 @book = Book.new
    	 @books = Book.find(params[:id])
      end

      def edit
         @book = Book.find(params[:id])
        
      end
      def destroy
          @book = Book.find(params[:id])
          @book.destroy
          redirect_to books_path

      end

    def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = 'successfully'
    redirect_to book_path(@book.id)
  else
    flash[:notice] = 'error'
    redirect_to book_path(@book.id)
   end
 end

    
private
    def book_params
        params.require(:book).permit(:title, :body)
    end
def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to  books_path
    end
end

end
