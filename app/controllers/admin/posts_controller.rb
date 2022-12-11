class Admin::PostsController < ApplicationController

        # before_actionでensure_correct_userメソッドを指定してください
        before_action :if_not_admin


        def index
          @posts = Post.all.order(created_at: :desc)
        end
        
        def show
          @post = Post.find_by(id: params[:id])
          @user = @post.user
        end
        
        def new
          @post = Post.new
          @users = User.order("admin")

          @user_id = User.find_by(id: params[:id])

          @user = User.all
          
          @today = Date.today
          from_date = Date.new(@today.year, @today.month, @today.beginning_of_month.day).beginning_of_week(:sunday)
          to_date = Date.new(@today.year, @today.month, @today.end_of_month.day).end_of_week(:sunday)
          @calendar_data = from_date.upto(to_date)
          @this_month =@today.month
          @posts = Post.all
          @post_id = Post.find_by(id: params[:id])
          @post_day = Post.find_by(date_day: @today)

          @wday = '今日は'+%w(日 月 火 水 木 金 土)[@today.wday] + '曜日'

          @admin = User.where(admin: true).count
          @user_count = @user.count

        end
        
        def create
          @day_link = params[:date]
          @day_format = @day_link.to_date

          @user = params[:id]

          @post = Post.new(
            date_day: @day_format,
            content: params[:content],
            user_id: @user
          )
          
          if @post.save
            flash[:notice] = "シフトを記入しました"
            redirect_to("/admin/posts/new")
          else
            render("/admin/posts/new")
          end
        end
        
        def edit
          @post = Post.new

          @day_link = params[:date]
          @day_format = @day_link.to_date

          @user = params[:id]
        end
        
        def update
          @post = Post.find_by(id: params[:id])
          @post.content = params[:content]
          if @post.save
            flash[:notice] = "シフトの時間を変更しました"
            redirect_to("/admin/posts/new")
          else
            render("/admin/posts/edit")
          end
        end
        
        def destroy
          @post = Post.find_by(id: params[:id])
          @post.destroy
          flash[:notice] = "シフトを削除しました"
          redirect_to("/admin/posts/new")
        end
        
        def if_not_admin
          if @current_user.admin != true
            flash[:notice] = "管理者権限がありません"
            redirect_to("/posts/new")
          end
        end

end
