class LikesController < ApplicationController

    def index
        has_user = params.has_key?(:user_id)
        has_art = params.has_key?(:artwork_id)
        table = has_art ? :liked_artworks : :liked_comments
        if has_user    
            @likes = User
                        .joins(table)
                        .where("likes.liker_id = ?",params[:user_id])
                        .where("likes.likeable_id = ?", id)
                        .where("likes.likeable_type=?",type)
        else 
            @likes = User
                        .joins(table)
                        .where("likes.likeable_id = ?", id)
                        .where("likes.likeable_type=?",type)
        end

        render json: @likes
    end

    def create
        @like = Like.new(liker_id: params[:user_id],likeable_type: type, likeable_id: id)
        if @like.save 
            render json: @like 
        else
            render json: @like.errors.full_message, status: :unprocessable_entity 
        end

    end

    def destroy
        @like = Like.where(params[:id])
        @like.destroy 
        render json: @like 
        redirect_to artwork_url(id)
    end

    def id 
        id = params[:artwork_id] ? params[:artwork_id] : params[:comment_id]
        id
    end
    def type 
        params[:artwork_id] ? 'Artwork'| 'Comment'
    end

    def like_params 
        #liker_id, likeable_type, likeable_id
        params.require(:like).permit(:user_id)
    end
end
