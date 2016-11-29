defmodule Nombook.Recipe do
  use Nombook.Web, :model

  schema "recipes" do
    field :title, :string
    field :description, :string
    field :origin, :string
    field :cook_time, :string
    field :prep_time, :string
    field :total_time, :string
    field :cooking_method, :string
    field :diet, :string
    field :serving_size, :string
    field :servings, :string
    field :nutrition, {:array, :map}
    field :ingredients, {:array, :map}
    field :instructions, {:array, :map}

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :origin, :cook_time, :prep_time, :total_time, :cooking_method, :diet, :serving_size, :servings, :nutrition, :ingredients, :instructions])
    |> validate_required([:title, :description, :origin, :cook_time, :prep_time, :total_time, :cooking_method, :diet, :serving_size, :servings, :nutrition, :ingredients, :instructions])
  end
end
