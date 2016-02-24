Rails.configuration.stripe = {
  :publishable_key => ENV['pk_test_uCiexElwTV4C0YSE33C1Nk4h'],
  :secret_key      => ENV['sk_test_Da6E7sceBHPnJaRo1Jz566Or']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]