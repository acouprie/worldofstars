class UsersActifsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ObiWan)
    @non_actif = users(:LukeSkywalker)
  end

  test "become actifs" do
    assert_equal true, User.where((["id = ? and last_connection > ?", @non_actif.id, 2.weeks.ago])).empty?
    log_in_as(@non_actif)
    assert_equal false, User.where((["id = ? and last_connection > ?", @non_actif.id, 2.weeks.ago])).empty?
  end

  test "unactif after 2 weeks" do
    log_in_as(@user)
    assert_equal false, User.where((["id = ? and last_connection > ?", @user.id, 2.weeks.ago])).empty?
    @user.update_attribute(:last_connection, 3.weeks.ago)
    assert_equal true, User.where((["id = ? and last_connection > ?", @user.id, 2.weeks.ago])).empty?
  end
end
