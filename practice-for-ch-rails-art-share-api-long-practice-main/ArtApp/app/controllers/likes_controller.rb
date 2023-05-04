class LikesController < ApplicationController

    def index
        has_user = params.has_key?(:user_id)
        has_art = params.has_key?(:artwork_id)
        has_comment = params.has_key?(:comment_id)
        type = has_art ? 'Artwork':"Comment" 
        if has_user    
            @likes = Like
                    .where("liker_id = ?",params[:user_id])
                    .where("likeable_id = ?", params[:artwork_id])
                    .where("likeable_type=?",type)
        else 
            @likes = Like
                    .where("likeable_id = ?", params[:artwork_id])
                    .where("likeable_type=?",type)
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
