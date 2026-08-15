import Config

if config_env() == :dev do
  # Watch static and templates for browser reloading.
  config :sbg_inv, SbgInv.Web.Endpoint,
    live_reload: [
      web_console_logger: true,
      patterns: [
        ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
        ~r{priv/gettext/.*(po)$},
        ~r{lib/sbg_inv/web/views/.*(ex)$},
        ~r{lib/sbg_inv/web/templates/.*(eex)$}
      ]
    ]
end
