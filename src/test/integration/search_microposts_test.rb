require 'test_helper'

class SearchMicropostsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
    @other_micropost = microposts(:not_t)
  end

  test "should search correct microposts" do
    log_in_as(@user)
    get root_path
    assert_select 'form.form-inline'
    assert_match CGI.escapeHTML(@other_micropost.content), response.body
    post search_microposts_path, xhr:true, params: { search: "orange!" }
    assert_template 'search_microposts/index'
    first_page_of_microposts = Micropost.search_micropost(attribute = "content",str = "orange!").paginate(page: 1)
    first_page_of_microposts.each do |micropost|
      assert_match CGI.escapeHTML(micropost.content), response.body
    end
    assert_no_match CGI.escapeHTML(@other_micropost.content), response.body
  end

  test "should pagenation worked" do
    log_in_as(@user)
    post search_microposts_path, xhr:true, params: { search: "t", page: 2 }
    second_page_of_microposts = Micropost.search_micropost(attribute = "content",str = "t").paginate(page: 2)
    second_page_of_microposts.each do |micropost|
      assert_match CGI.escapeHTML(micropost.content), response.body
    end
    #assert_no_match CGI.escapeHTML(@other_micropost.content), response.body
  end

end
