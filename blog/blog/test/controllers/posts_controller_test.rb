require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @auth = { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'supersecret') }
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url, headers: @auth
    assert_response :success
  end
  
  test "should not get new if unauthorized" do
    get new_post_url
    assert_response :unauthorized
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { content: @post.content, title: @post.title } }, headers: @auth
    end

    assert_redirected_to post_url(Post.last)
  end
  
  test "should not create post if unauthorized" do
    assert_difference('Post.count', 0) do
      post posts_url, params: { post: { content: @post.content, title: @post.title } }
    end
    
    assert_response :unauthorized
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post), headers: @auth
    assert_response :success
  end
  
  test "should not get edit if unauthorized" do
    get edit_post_url(@post)
    assert_response :unauthorized
  end

  test "should update post" do
    patch post_url(@post), params: { post: { content: @post.content, title: @post.title } }, headers: @auth
    assert_redirected_to post_url(@post)
  end
  
  test "should not update post if unauthorized" do
    patch post_url(@post), params: { post: { content: @post.content, title: @post.title } }
    assert_response :unauthorized
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post), headers: @auth
    end

    assert_redirected_to posts_url
  end
  
  test "should not destroy postif unauthorized" do
    assert_difference('Post.count', 0) do
      delete post_url(@post)
    end
    
    assert_response :unauthorized
  end
end
