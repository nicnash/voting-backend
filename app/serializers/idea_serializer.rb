class IdeaSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :count, :created_at
  # has_one :user
end
