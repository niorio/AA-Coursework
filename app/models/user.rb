class User < ActiveRecord::Base
  validate :user_name, :presence => true, :uniqueness => true

  def completed_polls

    # Poll.find_by_sql(
    # [
      # "SELECT
      #   polls.*, COUNT(questions.*) AS question_count, COUNT(my_responses.*) AS response_count
      # FROM
      #   polls
      # JOIN
      #   questions ON questions.poll_id = polls.id
      # LEFT OUTER JOIN
      #   (
      #     SELECT
      #       *
      #     FROM
      #       responses
      #     WHERE
      #       responses.user_id = ?
      #   ) AS my_responses ON my_responses.question_id = questions.id
      # GROUP BY
      #   polls.id
      # HAVING
      #   COUNT(questions.*) = COUNT(my_responses.*)", self.id])
    #
    # Poll.find(:all,
    #           :joins => "JOIN questions ON questions.poll_id = polls.id
    #                     LEFT OUTER JOIN responses ON responses.question_id = questions.id",
    #           :conditions =>"responses.user_id = #{id}",
    #           :group => "polls.id",
    #           :having=> "COUNT(questions.*) = COUNT(responses.*)")

    Poll.all
        .joins("JOIN questions ON questions.poll_id = polls.id
                  LEFT OUTER JOIN responses ON responses.question_id = questions.id")
        .where("responses.user_id = #{id}")
        .group("polls.id")
        .having("COUNT(questions.*) = COUNT(responses.*)")




  end





  has_many(
    :authored_polls,
    :class_name => "Poll",
    :foreign_key => :author_id,
    :primary_key => :id
  )

  has_many(
    :responses,
    :class_name => "Response",
    :foreign_key => :user_id,
    :primary_key => :id
  )



end
