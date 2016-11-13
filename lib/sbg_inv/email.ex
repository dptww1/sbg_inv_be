defmodule SbgInv.Email do
  use Bamboo.Phoenix, view: SbgInv.EmailView

  def forgot_password_email(email_address, new_password) do
    new_email
    |> to(email_address)
    |> from("dave@davetownsend.org")
    |> subject("Password Reset")
    |> text_body("Your new password is #{new_password}")
  end
end
