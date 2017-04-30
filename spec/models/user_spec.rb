describe User, type: :model  do
  describe "#possible_opponents" do
    it "returns all users except for the user it's invoked on" do
      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)
      expect(user_1.possible_opponents).to match_array([user_2, user_3])
      expect(user_2.possible_opponents).to match_array([user_1, user_3])
      expect(user_3.possible_opponents).to match_array([user_1, user_2])
    end
  end

  it "creates a Score entry for each new user" do
    expect(Score).to receive(:create_entry_for_user)
    create(:user)
  end
end
