module Types
  class MutationType < Types::BaseObject
    field :create_author, Types::AuthorType, mutation: Mutations::CreateAuthor
    field :update_author, Boolean, null: false, description: 'Update a author' do
      argument :author, Types::AuthorInputType, required: true
    end

    field :delete_author, Boolean, null: false, description: 'Delete a author' do
      argument :id, ID, required: true
    end

    def delete_author(id:)
      existing_author = Author.find_by(id: id)
      existing_author.destroy
    end
  end
end
