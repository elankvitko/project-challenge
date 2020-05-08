require 'rails_helper'

describe 'Dog resource', type: :feature do
  before :each do
    @user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  it 'can create a profile' do
    visit new_dog_path
    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'Images', 'spec/fixtures/images/speck.jpg'
    click_button 'Create Dog'
    expect(Dog.count).to eq(1)
  end

  it 'can edit a dog profile' do
    dog = create(:dog, user: @user)
    visit edit_dog_path(dog)
    fill_in 'Name', with: 'Spock'
    click_button 'Update Dog'
    expect(dog.reload.name).to eq('Spock')
  end

  it 'can delete a dog profile' do
    dog = create(:dog, user: @user)
    visit dog_path(dog)
    click_link "Delete #{dog.name}'s Profile"
    expect(Dog.count).to eq(0)
  end
end
