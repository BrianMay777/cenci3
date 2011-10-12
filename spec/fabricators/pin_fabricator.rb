Fabricator(:pin) do
  pin { ((0..9).to_a.map { |i| rand(9) }).join }
  provider { AppConfig.providers[rand(AppConfig.providers.length)] }
end
