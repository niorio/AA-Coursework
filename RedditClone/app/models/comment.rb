class Comment < ActiveRecord::Base

  validates :author, :post, :body, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :comments

  belongs_to :post,
    class_name: "Post",
    foreign_key: :post_id,
    primary_key: :id,
    inverse_of: :comments

  has_many :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    primary_key: :id,
    inverse_of: :parent_comment

  belongs_to :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    primary_key: :id,
    inverse_of: :child_comments

  has_many :votes,
    class_name: 'Vote',
    foreign_key: :votable_id,
    primary_key: :id,
    inverse_of: :votable,
    as: :votable

  def author_name
    author.username
  end

end
