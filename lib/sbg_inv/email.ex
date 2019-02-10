defmodule SbgInv.Email do
  use Bamboo.Phoenix, view: SbgInv.EmailView

  def forgot_password_email(email_address, new_password) do
    new_email()
    |> to(email_address)
    |> from(System.get_env("SMTP_SENDER"))
    |> subject("Password Reset")
    |> text_body("Your new password is #{new_password}")
  end
end
