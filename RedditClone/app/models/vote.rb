class Vote < ActiveRecord::Base
  validates_inclusion_of :value, in: [-1, 1]
  validates_inclusion_of :votable_type, in: ['Post', 'Comment']
  validate :votable_type, :votable_id, :voter_id, presence: true

  belongs_to :votable,
    class_name: :votable_type,
    foreign_key: :votable_id,
    primary_key: :id,
    polymorphic: true,
    inverse_of: :votes

  belongs_to :voter,
    class_name: 'User',
    foreign_key: :voter_id,
    primary_key: :id,
    inverse_of: :votes

end
