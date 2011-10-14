class AgentsController < ApplicationController
  before_filter :require_agent

  def show
    @approved_accounts = Account.approved
    @pending_accounts = Account.pending_approval
  end
end
