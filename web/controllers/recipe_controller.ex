defmodule Nombook.RecipeController do
  use Nombook.Web, :controller

  alias Nombook.Recipe

  def index(conn, _params) do
    recipes = Repo.all(Recipe)
    render(conn, "index.json", recipes: recipes)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    changeset = Recipe.changeset(%Recipe{}, recipe_params)

    case Repo.insert(changeset) do
      {:ok, recipe} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", recipe_path(conn, :show, recipe))
        |> render("show.json", recipe: recipe)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Nombook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe = Repo.get!(Recipe, id)
    render(conn, "show.json", recipe: recipe)
  end

  def update(conn, %{"id" => id, "recipe" => recipe_params}) do
    recipe = Repo.get!(Recipe, id)
    changeset = Recipe.changeset(recipe, recipe_params)

    case Repo.update(changeset) do
      {:ok, recipe} ->
        render(conn, "show.json", recipe: recipe)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Nombook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe = Repo.get!(Recipe, id)
    Repo.delete!(recipe)
    send_resp(conn, :no_content, "")
  end

  def extractor(html, url) do
    %{}
    |> Map.put_new(:cook_time, Floki.find(html, "[itemprop=cookTime]")
      |> Floki.text)
    |> Map.put_new(:cooking_method, Floki.find(html, "[itemprop=cookingMethod]")
      |> Floki.text)
    |> Map.put_new(:description, Floki.find(html, "[itemprop=description]")
      |> Floki.text)
    |> Map.put_new(:diet, Floki.find(html, "[itemprop=suitableForDiet]")
      |> Floki.text)
    |> Map.put_new(:origin, url)
    |> Map.put_new(:prep_time, Floki.find(html, "[itemprop=prepTime]")
      |> Floki.text)
    |> Map.put_new(:servings, Floki.find(html, "[itemprop=recipeYield]")
      |> Floki.text)
    |> Map.put_new(:serving_size, Floki.find(html, "[itemprop=servingSize]")
      |> Floki.text)
    |> Map.put_new(:total_time, Floki.find(html, "[itemprop=totalTime]")
      |> Floki.text)
    |> Map.put_new(:title, Floki.find(html, "[itemprop=name]")
      |> Floki.text)
  end
end
