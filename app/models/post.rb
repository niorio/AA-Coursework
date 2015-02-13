class Post < ActiveRecord::Base

  validates :title, :author, :subs, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :posts

  has_many :post_subs,
    class_name: "PostSub",
    foreign_key: :post_id,
    primary_key: :id,
    inverse_of: :post

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments,
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id,
    inverse_of: :post

  has_many :votes,
    class_name: 'Vote',
    foreign_key: :votable_id,
    primary_key: :id,
    inverse_of: :votable,
    as: :votable

  def score
    votes.inject(0) { |sum, vote| sum + vote.value }
  end

  def author_name
    author.username
  end

  def comments_by_parent_id
    comments_by_parent_id = Hash.new { |h,k| h[k] = [] }
    all_comments = self.comments.includes(:author)

    all_comments.each do |comment|
      comments_by_parent_id[comment.parent_comment_id] << comment
    end

    comments_by_parent_id
  end

end
