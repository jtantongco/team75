class CreateProjectFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :project_feedbacks, :id => false do |t|
      t.primary_key   :f_id
      t.integer       :project_id,    :null => false
      t.integer       :volunteer_id,  :null => false
      t.string        :feedback,      :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :project_feedbacks
  end
end
