class UpdateDefaultValue < ActiveRecord::Migration[7.1]
  def change
    change_column :film, :last_update, :datetime, default: -> { 'datetime(\'now\')' }
    change_column :actor, :last_update, :datetime, default: -> { 'datetime(\'now\')' }
  end
end
