class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :member
end
