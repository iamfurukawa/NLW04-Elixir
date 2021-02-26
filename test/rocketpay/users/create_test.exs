defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.Users.Create
  alias Rocketpay.User

  describe "call/1" do
    test "When all params are valid, returns an user" do
      params = %{
        name: "Vinicius",
        password: "teste123",
        nickname: "iamfurukawa",
        email: "vinicius_furuka@hotmail.com.br",
        age: 24
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Vinicius", age: 24, id: ^user_id} = user
    end

    test "When all params are invalid, returns an error" do
      params = %{
        name: "Vinicius",
        nickname: "iamfurukawa",
        email: "vinicius_furuka@hotmail.com.br",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
