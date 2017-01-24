class CreateMerchants < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :merchants do |t|
      t.citext     :name
      t.datetime   :created_at
      t.datetime   :updated_at
    end
  end
end
