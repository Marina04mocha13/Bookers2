class RemoveFolloweIdFromRelationships < ActiveRecord::Migration[6.1]
  def change
    remove_column :relationships, :followe_id, :integer
  end
end
