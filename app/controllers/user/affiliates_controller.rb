# frozen_string_literal: true

class User::AffiliatesController < UserController
  def index
    @q = policy_scope(Affiliate).ransack(params[:q])
    result = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @affiliates = pagy(result, items: 10)
  end
end
