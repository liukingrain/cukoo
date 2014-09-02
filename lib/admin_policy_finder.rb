class AdminPolicyFinder < Pundit::PolicyFinder
  private
  
  def find
    policy_name = "Admin::#{super}"
    policy_name.safe_constantize ? policy_name : "AdminPolicy"
  end
end