class PostsController < ApplicationController
  def new
    @post = Post.new
    
    @today = Date.today.next_month
    from_date = Date.new(@today.year, @today.month, @today.beginning_of_month.day).beginning_of_week(:sunday)
    to_date = Date.new(@today.year, @today.month, @today.end_of_month.day).end_of_week(:sunday)
    @calendar_data = from_date.upto(to_date)
    @this_month =@today.month
    @posts = Post.all
  end
end