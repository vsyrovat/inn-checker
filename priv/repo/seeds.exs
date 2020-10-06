# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias App.Auth

Auth.create_user!(%{login: "admin", password: "admin", is_admin: true, is_operator: true})
Auth.create_user!(%{login: "operator", password: "operator", is_admin: false, is_operator: true})
