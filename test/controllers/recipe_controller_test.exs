defmodule Nombook.RecipeControllerTest do
  use Nombook.ConnCase

  alias Nombook.Recipe
  @valid_attrs %{
    cook_time: "35 Minutes",
    cooking_method: "Oven",
    description: "A nice cherry pie from Twin Peaks",
    diet: "Vegitarian",
    ingredients: [
      %{amount: 1, unit: "c", what: "flour"},
      %{amount: 0.5, unit: "c", what: "Crisco"},
      %{amount: 0.25, unit: "c", what: "ice water"},
      %{amount: 3, unit: "c", what: "cherries"},
      %{amount: 1, unit: "c", what: "water"},
      %{amount: 1, unit: "c", what: "sugar"},
      %{amount: 4, unit: "T", what: "cornstarch"},
      %{amount: 0.125, unit: "t", what: "salt"}
    ],
    instructions: [
      %{instruction: "Mix flour and Crisco with fork."},
      %{instruction: "Add ice water."},
      %{instruction: "Mix with your hands."},
      %{instruction: "When blended, roll into ball and refrigerate overnight."},
      %{instruction: "To roll out: flour both rolling pin and flat surface, split ball in two, roll out 1/2 to fit pan and 1/2 for lattice."},
      %{instruction: "Thaw cherries at room temp and strain (yields 2 c juice)."},
      %{instruction: "Taste for sweetness, more/less sugar may be needed."},
      %{instruction: "Add 1 c water to make 3 c juice (reserve 1 c juice for cornstarch mix)."},
      %{instruction: "Dissolve cornstarch in 1 c juice, stir with whip."},
      %{instruction: "Combine 2 c juice, 2/3 c sugar, salt, and bring to a boil."},
      %{instruction: "Add cornstarch mix, cook until clear, about 5 min (if cooked too long, syrup gets gummy)."},
      %{instruction: "Remove from heat, stir in 1/3 c sugar (blend thoroughly)."},
      %{instruction: "Pour mixture over cherries, fold with wooden spoon, cool (stir mix while cooling to prevent scum from forming on top)."},
      %{instruction: "Pour mix inpie shell."},
      %{instruction: "Top completed pie with lattice crust"}
    ],
    nutrition: [
      %{item: "calories", amount: "250", unit: "kcal"}
    ],
    origin: "http://www.lynchnet.com/tp/tpcard07.html",
    prep_time: "30 Minutes",
    serving_size: "1/8 of pie",
    servings: "8 slices",
    title: "Twin Peaks Cherry Pie",
    total_time: "1 Hour"}
  @invalid_attrs %{}

  @valid_html """
    <html lang="en">
    <body>
      <div class="wrapper">
        <div class="recipe" itemscope itemtype="http://schema.org/Recipe">
          <div class="recipe-meta">
            <h1 itemprop="name">Twin Peaks Cherry Pie</h1>
            <p itemprop="description">A nice cherry pie from Twin Peaks</p>
            <div class="small-info">
              <div class="cooking">
                <h4 itemprop="suitableForDiet">Vegitarian</h4>
                <h4 itemprop="cookingMethod">Oven</h4>
              </div>
              <div class="times">
                <h4 itemprop="prepTime" content="PT30M">30 Minutes</h4>
                <h4 itemprop="cookTime" content="PT35M">35 Minutes</h4>
                <h4 itemprop="totalTime" content="PT1H">1 Hour</h4>
              </div>
              <div class="serving-col">
                <h4 itemprop="servingSize">1/8 of pie</h4>
                <h4 itemprop="recipeYield">8 slices</h4>
              </div>
            </div>
          </div>
          <div class="recipe-ingredients">
            <h2>Ingredients</h2>
            <ul class="ingredient-list">
              <li itemprop="recipeIngredient">1c flour</li>
              <li itemprop="recipeIngredient">1/2c Crisco</li>
              <li itemprop="recipeIngredient">1/4c ice water</li>
              <li itemprop="recipeIngredient">3c cherries</li>
              <li itemprop="recipeIngredient">1c water</li>
              <li itemprop="recipeIngredient">1c sugar</li>
              <li itemprop="recipeIngredient">4T cornstarch</li>
              <li itemprop="recipeIngredient">1/8t salt</li>
            </ul>
          </div>
          <div class="recipe-instructions">
            <h2>Instructions</h2>
            <ol class="instruction-list">
              <li itemprop="recipeInstructions"><p>Mix flour and Crisco with fork.</p></li>
              <li itemprop="recipeInstructions"><p>Add ice water.</p></li>
              <li itemprop="recipeInstructions"><p>Mix with your hands.</p></li>
              <li itemprop="recipeInstructions"><p>When blended, roll into ball and refrigerate overnight.</p></li>
              <li itemprop="recipeInstructions"><p>To roll out: flour both rolling pin and flat surface, split ball in two, roll out 1/2 to fit pan and 1/2 for lattice.</p></li>
              <li itemprop="recipeInstructions"><p>Thaw cherries at room temp and strain (yields 2 c juice).</p></li>
              <li itemprop="recipeInstructions"><p>Taste for sweetness, more/less sugar may be needed.</p></li>
              <li itemprop="recipeInstructions"><p>Add 1 c water to make 3 c juice (reserve 1 c juice for cornstarch mix).</p></li>
              <li itemprop="recipeInstructions"><p>Dissolve cornstarch in 1 c juice, stir with whip.</p></li>
              <li itemprop="recipeInstructions"><p>Combine 2 c juice, 2/3 c sugar, salt, and bring to a boil.</p></li>
              <li itemprop="recipeInstructions"><p>Add cornstarch mix, cook until clear, about 5 min (if cooked too long, syrup gets gummy).</p></li>
              <li itemprop="recipeInstructions"><p>Remove from heat, stir in 1/3 c sugar (blend thoroughly).</p></li>
              <li itemprop="recipeInstructions"><p>Pour mixture over cherries, fold with wooden spoon, cool (stir mix while cooling to prevent scum from forming on top).</p></li>
              <li itemprop="recipeInstructions"><p>Pour mix inpie shell.</p></li>
              <li itemprop="recipeInstructions"><p>Top completed pie with lattice crust</p></li>
            </ol>
          </div>
          <div class="recipe-nutrition" itemprop="nutrition">
            <span itemprop="calories">250 calories</span>
          </div>
        </div>
      </div>
    </body>
    </html>
  """

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2" do
    test "Gets all the recipes", %{conn: conn} do
      conn = get conn, recipe_path(conn, :index)
      assert json_response(conn, 200)["recipes"] == []
    end
  end

  describe "create/2" do
    test "Creates a recipe from attributes, then returns it", %{conn: conn} do
      conn = post conn, recipe_path(conn, :create), recipe: @valid_attrs
      assert json_response(conn, 201)["recipe"]["id"]
      assert Repo.get_by(Recipe, @valid_attrs)
    end

    test "Does not create recipe if attributes are invalid", %{conn: conn} do
      conn = post conn, recipe_path(conn, :create), recipe: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "show/2" do
    test "Shows a recipe from ID", %{conn: conn} do
      recipe = Repo.insert! %Recipe{}
      conn = get conn, recipe_path(conn, :show, recipe)
      assert json_response(conn, 200)["recipe"] == %{"id" => recipe.id,
        "title" => recipe.title,
        "description" => recipe.description,
        "origin" => recipe.origin,
        "cook_time" => recipe.cook_time,
        "prep_time" => recipe.prep_time,
        "total_time" => recipe.total_time,
        "cooking_method" => recipe.cooking_method,
        "diet" => recipe.diet,
        "serving_size" => recipe.serving_size,
        "servings" => recipe.servings,
        "nutrition" => recipe.nutrition,
        "ingredients" => recipe.ingredients,
        "instructions" => recipe.instructions}
    end
 
    test "Shows 404 if ID is not found", %{conn: conn} do
      assert_error_sent 404, fn ->
        get conn, recipe_path(conn, :show, -1)
      end
    end
  end

  describe "update/2" do
    test "Updates and renders selected recipe", %{conn: conn} do
      recipe = Repo.insert! %Recipe{}
      conn = put conn, recipe_path(conn, :update, recipe), recipe: @valid_attrs
      assert json_response(conn, 200)["recipe"]["id"]
      assert Repo.get_by(Recipe, @valid_attrs)
    end

    test "Does not update recipe when attributes are invalid", %{conn: conn} do
      recipe = Repo.insert! %Recipe{}
      conn = put conn, recipe_path(conn, :update, recipe), recipe: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete/2" do
    test "Deletes selected recipe", %{conn: conn} do
      recipe = Repo.insert! %Recipe{}
      conn = delete conn, recipe_path(conn, :delete, recipe)
      assert response(conn, 204)
      refute Repo.get(Recipe, recipe.id)
    end
  end

  describe "extractor/1" do
    test "Can extract recipe from HTML using schema.org/Recipe" do
      temp_attrs = %{
        cook_time: "35 Minutes",
        cooking_method: "Oven",
        description: "A nice cherry pie from Twin Peaks",
        diet: "Vegitarian",
        origin: "http://www.lynchnet.com/tp/tpcard07.html",
        prep_time: "30 Minutes",
        serving_size: "1/8 of pie",
        servings: "8 slices",
        title: "Twin Peaks Cherry Pie",
        total_time: "1 Hour"}


      extracted_data = Nombook.RecipeController.extractor(@valid_html, temp_attrs.origin)
      assert extracted_data == temp_attrs
    end
  end
end
