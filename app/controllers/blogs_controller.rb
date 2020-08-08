class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    if !current_user
      @blogs = Blog.where(status: 2)
    elsif current_user.member?
      @blogs= Blog.where('status = ? OR status = ?', 1, 2)
    else # current_user.author?
      @blogs = Blog.where('user_id = ? OR status = ? OR status = ?', current_user.id, 1, 2)
      # @blogs = current_user.blogs.or( Blog.where(status: 1).or(Blog.where(status: 2)) ) # I prefer the SQL syntax much better
    end

    return @blogs if params[:search].blank?

    sql = <<-SQL
      (select b.id from blogs b
      left join blogs_categories bc on bc.blog_id = b.id
      left join categories c on c.id = bc.category_id
      where b.title like ?
      or c.name = ?)
    SQL

    search_params = params[:search]
    blog_ids = Blog.find_by_sql([sql, "\%#{search_params}\%", "#{search_params}"]).pluck(:id)

    blogs_from_search = Blog.where(id: blog_ids)
    @blogs = @blogs.merge(blogs_from_search)

    # Rails: Combine Two ActiveRecord::Relation Objects
    # combine using AND (intersection), use merge
    # combine using OR (union), use or

    # Examples
    # Blog.where('id < 1').merge(Blog.where(id: 4))
    # => #<ActiveRecord::Relation []>
    # Blog.where('id < 1').or(Blog.where(id: 4))
    # => #<ActiveRecord::Relation [#<Blog id: 4, user_id: 3, title: "Joes paid blog 1", body: "content for joes paid blog 1", status: "Paid", created_at: "2020-08-02 07:26:37", updated_at: "2020-08-02 07:26:37">]>
    # Blog.where('id in (2,4)').merge(Blog.where(id: 4))
    # => #<ActiveRecord::Relation [#<Blog id: 4, user_id: 3, title: "Joes paid blog 1", body: "content for joes paid blog 1", status: "Paid", created_at: "2020-08-02 07:26:37", updated_at: "2020-08-02 07:26:37">]>


    # Syntax to render default 404 page
    # render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:user_id, :title, :body, :status, category_ids: [])
    end
end
