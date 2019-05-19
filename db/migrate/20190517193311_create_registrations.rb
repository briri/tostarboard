class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.boolean    :paid, default: false
      t.datetime   :paid_on
      t.string     :invoice_id
      t.text       :notes
      t.belongs_to :user, index: true
      t.belongs_to :series, index: true
      t.belongs_to :event, index: true
      t.timestamps
    end
  end
end
