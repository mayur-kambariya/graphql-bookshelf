module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :author, Types::AuthorType, null: true, description: 'Return one author' do
      argument :id, ID, required: true
    end

    def author(id:)
      Author.find_by(id: id)
    end

    field :authors, [Types::AuthorType], null: false

    def authors
      Author.all
    end

    field :login, String, null: true, description: 'User login' do
      argument :email, String, required: true
      argument :password, String, required: true
    end

    def login(email:, password:)
      user = User.find_by(email: email)&.authenticate(password)
      if user.present?
        user.sessions.create.key
      end
    end

    field :current_user, Types::UserType, null: true, description: 'User details'

    def current_user
      context[:current_user]
    end

    field :logout, Boolean, null: true, description: 'logout'


    def logout
      session = Session.find_by(id: context[:session_id])
      session&.destroy
    end
  end
end
