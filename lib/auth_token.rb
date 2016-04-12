class AuthToken
  attr_reader :token, :payload

  def initialize(payload: {}, token: nil)
    if token.present?
      @payload, _ = JWT.decode(token, secret_key, true, options)
      @token = token
    else
      @payload = payload
      @token = JWT.encode(payload.merge({ exp: expires_in }), secret_key, token_signature_algorithm)
    end
  end

  def current_user
    @current_user ||= User.find(@payload["user_id"])
  end


  private

  def secret_key
    Rails.application.secrets.secret_key_base
  end

  def token_signature_algorithm
    'HS512'
  end

  def options
    { algorithm: token_signature_algorithm }
  end

  def expires_in
    15.minutes.from_now.to_i
  end
end
