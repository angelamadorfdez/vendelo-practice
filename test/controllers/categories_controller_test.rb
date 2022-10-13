require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  test 'render a list of products' do
    get categories_path

    assert_response :success
    assert_select '.category', 10
  end

  test 'show category' do
    get category_path(categories(:videogames))

    assert_response :success
    assert_select 'h2', 'Videojuegos'
  end

  test 'show new category form' do
    get new_category_path

    assert_response :success
    assert_select 'form'
  end

  test 'allow create new category' do
    assert_difference('Category.count', 1) do
      post categories_path, params: {
        category: {
          name: 'Casas',
          slug: 'casas'
        }
      }
    end
    
    assert_redirected_to categories_path
    assert_equal flash[:notice], 'Tu categoría se ha creado correctamente'
    
  end

  test 'do not allow create new category without slug' do
      post categories_path, params: {
        category: {
          name: 'Ropa',
          slug: ''
        }
      }
    
    assert_response :unprocessable_entity    
  end

  test 'allow update a product' do
    patch category_path(categories(:videogames)), params: {
      category: {
        name: 'Juegos'
      }
    }

    assert_redirected_to categories_path
  end

  test 'dont allow update a categoru with an invalid field' do
    patch category_path(categories(:videogames)), params: {
      category: {
        name: nil
      }
    }

    assert_response :unprocessable_entity    
  end 

  test 'allow to delete a category with no products' do
    assert_difference('Category.count', -1) do
      delete category_path(categories(:beauty))
    end

    assert_redirected_to categories_path
    assert_equal flash[:notice], 'La categoría se ha borrado correctamente'

  end

end
