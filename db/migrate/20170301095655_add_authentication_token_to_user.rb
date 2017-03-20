class AddAuthenticationTokenToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :authentication_token, :string

    User.find_each do |user|
      user.ensure_authentication_token
      user.save
    end
  end

  def down
    remove_column :users, :authentication_token
  end
end
