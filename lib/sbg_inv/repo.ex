defmodule SbgInv.Repo do
  use Ecto.Repo,
      otp_app: :sbg_inv,
      adapter: Ecto.Adapters.Postgres
end
