class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  accepts_nested_attributes_for :user, reject_if: :all_blank

  def user_attributes=(user)
    if !user[:username].empty?
      new_user = User.create(username: user[:username])
      self.user = new_user
    end
  end

end
