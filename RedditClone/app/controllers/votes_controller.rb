class VotesController < ApplicationController

  def upvote
    Vote.create(votable_id: votable_id, votable_type: votable_type,
      voter_id: current_user.id, value: 1)
      redirect_to :back
  end

  def downvote
    Vote.create(votable_id: votable_id, votable_type: votable_type,
      voter_id: current_user.id, value: -1)
    redirect_to :back
  end

  private

    def parse_id
      params.keys.select { |key| key =~ /id/ }.first
    end

    def votable_type
      parse_id.slice(0..-4).capitalize
    end

    def votable_id
      params[parse_id.to_sym].to_i
    end
end
