class Services::OauthUserService
  
  attr_reader :auth
  
  def initialize(auth)
    @auth = auth
  end
  
  def user
    @user ||= (find_user_by_provider || find_user_by_email || build_user)
  end
  
  private
  
  def find_user_by_email
    user = User.find_by(email: auth.info.email)
    user.update_columns(provider: auth.provider) if user
    user
  end
  
  def build_user
    User.new(email: auth.info.email, 
              first_name: auth.info.first_name, 
              last_name: auth.info.last_name,
              confirmed_at: Time.now,
              password: Devise.friendly_token[0,20],
              provider: auth.provider, 
              )
  end
  
  def find_user_by_provider
    User.find_by(provider: auth.provider)
  end
end
