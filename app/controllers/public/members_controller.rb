class Public::MembersController < ApplicationController
  def show
    @member = current_member
  end

  def edit
  end

  def unsubscribe
  end
end
