class Types::UserType < Types::BaseObject

  description 'User'

  field :id, ID, null: false
  field :email, String, null: true
  field :is_superadmin, Boolean, null: true

  def self.visible?(context)
    !!context[:current_user]
  end
end