class LikesController < ApplicationController

    def index
        has_user = params.has_key?(:user_id)
        has_art = params.has_key?(:artwork_id)

        type = has_art ? 'Artwork':"Comment" 
        id = has_art ? params[:artwork_id] : params[:comment_id]
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
    end

    def destroy
    end

    def like_params 

    end
end
