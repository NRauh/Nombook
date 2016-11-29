defmodule Nombook.Repo.Migrations.CreateRecipe do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :title, :text
      add :description, :text
      add :origin, :text
      add :cook_time, :text
      add :prep_time, :text
      add :total_time, :text
      add :cooking_method, :text
      add :diet, :text
      add :serving_size, :text
      add :servings, :text
      add :nutrition, {:array, :map}
      add :ingredients, {:array, :map}
      add :instructions, {:array, :map}

      timestamps()
    end

  end
end
