defmodule SbgInv.Email do
  import Swoosh.Email

  alias SbgInv.Mailer

  def forgot_password_email(email_address, reset_token) do
    fe_url = System.get_env("SBG_INV_FE_URL")

    new()
    |> to(email_address)
    |> from("dave@sbginventory.com")
    |> bcc("dave@davetownsend.org")
    |> subject("SBG Inventory Password Reset Request")
    |> html_body("""
    <p>The SBG Inventory site received a request to reset the password for this email account.</p>
    <p>If you did not initiate the request, you can ignore this email and continue to log in normally.</p>
    <p>To set a new password for your account, use
    <a href="#{fe_url}/reset-password?token=#{reset_token}">this link</a>
    to fill out your email and a new password, then click Reset Password.</p>
    <p>Thanks for using SBG Inventory.  Please consider supporting the site on
    <a href="https://www.patreon.com/SBGInventory">Patreon</a>.</p>
    """)
    |> Mailer.deliver()
  end
end
