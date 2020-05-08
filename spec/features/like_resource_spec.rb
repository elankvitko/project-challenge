require 'rails_helper'

describe 'Like resource', type: :feature do
  before :each do
    @user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  it 'can like a dog' do
    dog = create(:dog)
    visit dog_path(dog)
    click_button 'Like'
    expect(dog.likes.count).to eq(1)
  end

  it 'can not like own Dog' do
    dog = create(:dog, user: @user)
    visit dog_path(dog)
    expect(page).to_not have_selector(:link_or_button, 'Like')
  end
end
