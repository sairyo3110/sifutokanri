class PostsController < ApplicationController
  before_action :authenticate_user
  # before_actionでensure_correct_userメソッドを指定してください
  before_action :user_correct_user, {only: [:edit, :update, :destroy]}
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end
  
  def new
    @post = Post.new
    @posts = Post.all
    @users = User.order("admin")

    @user_id = User.find_by(id: params[:id])
    @day_link = params[:date]
    @day_format = @day_link.to_date
          
    @today = Date.today
    from_date = Date.new(@today.year, @today.month, @today.beginning_of_month.day).beginning_of_week(:sunday)
    to_date = Date.new(@today.year, @today.month, @today.end_of_month.day).end_of_week(:sunday)
    @calendar_data = from_date.upto(to_date)
    @this_month =@today.month
  end
  
  def create
    @day_link = params[:date]
    @day_format = @day_link.to_date

    @post = Post.new(
      content: params[:content],
      date_day: @day_format,
      user_id: @current_user.id
    )
    if @post.save
      flash[:notice] = "シフトを記入しました"
      redirect_to("/users/#{@current_user.id}")
    else
      render("/users/#{@current_user.id}")
    end
  end

  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "シフトの時間を変更しました"
      redirect_to("/users/#{@current_user.id}")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "シフトを削除しました"
    redirect_to("/users/#{@current_user.id}")
  end
 
  def reader_correct_user
    @post = Post.find_by(id: params[:id])
    if  @current_user.admin == false
      flash[:notice] = "権限がありません"
      redirect_to("/posts/new")
    end
  end

  # ensure_correct_userメソッドを定義してください
  # =!で全部できる
  def user_correct_user
    @post = Post.find_by(id: params[:id])
    if  @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/new")
    end
  end
  
  
end