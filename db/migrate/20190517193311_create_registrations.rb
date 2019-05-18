class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.boolean    :paid, default: false
      t.datetime   :paid_on
      t.string     :invoice_id
      t.text       :notes
      t.references :user, index: true
      t.references :series, index: true
      t.references :events, index: true
      t.timestamps
    end
  end
end
