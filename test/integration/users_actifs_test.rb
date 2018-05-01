class UsersActifsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ObiWan)
    @non_actif = users(:LukeSkywalker)
  end

  test "become actifs" do
    assert_equal false, @non_actif.actif?
    log_in_as(@non_actif)
    @non_actif.update_last_connection
    assert_equal true, @non_actif.actif?
  end

  test "unactif after 2 weeks" do
    log_in_as(@user)
    assert_equal true, @user.actif?
    @user.update_attribute(:last_connection, 3.weeks.ago)
    assert_equal false, @user.actif?
  end
end
