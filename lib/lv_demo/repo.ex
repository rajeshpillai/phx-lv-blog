defmodule LvDemo.Repo do
  use Ecto.Repo,
    otp_app: :lv_demo,
    adapter: Ecto.Adapters.Postgres
end
