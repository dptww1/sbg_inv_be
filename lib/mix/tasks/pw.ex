defmodule Mix.Tasks.Pw do
  @requirements ["app.config"]
  @shortdoc "Generate the hash for the password on the command line"

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    if length(args) == 0 do
      Mix.shell().error("usage: mix pw <password>")
    else
      pw = Enum.join(args, " ")
      Mix.shell().info("Here's the hash for password [#{pw}]")
      Mix.shell().info(Pbkdf2.hash_pwd_salt(pw))
    end
  end
end
