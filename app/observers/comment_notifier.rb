class CommentNotifier <Notifier
  observe :comment 

  def after_create(comment)
    commentable = comment.commentable
    user = comment.user
    target = commentable.user
    return if user == target # Don't notify someone commenting on their own stuff. :)

    data = {
      "user_id" => user.id,
      "username" => user.name,
      "comment_id" => comment.id,
      "comment_body" => comment.contents,
      "commentable_type" => comment.commentable_type,
      "commentable_id" => comment.commentable_id, 
      "commentable_title" => commentable.title,
      "commentable_url" => "/#{comment.commentable_type.underscore.pluralize}/#{comment.commentable_id}",
    }

    notify(target, "comment_create", comment, data)
  end

end