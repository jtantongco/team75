class RenameTablesAccordingToConvention < ActiveRecord::Migration
  def self.up
    rename_column :volunteer_extras,             :v_id,                :volunteer_id

    rename_table  :orientation_projects,         :orientations_projects
    rename_column :orientations_projects,        :p_id,                :project_id
    rename_column :orientations_projects,        :o_id,                :orientation_id

    rename_column :self_reports,                 :v_id,                :volunteer_id
    rename_column :self_reports,                 :p_id,                :project_id
    rename_column :self_reports,                 :s_id,                :supervisor_id
    
    rename_column :students,                      :v_id,                :volunteer_id
    
    rename_table  :volunteer_projects,           :volunteers_projects
    rename_column :volunteers_projects,          :v_id,                :volunteer_id
    rename_column :volunteers_projects,          :p_id,                :project_id

    rename_column :volunteer_project_interests, :v_id,                :volunteer_id
    rename_column :volunteer_project_interests, :p_id,                :project_id
    
    rename_table  :orientation_registrations,    :volunteers_orientations
    rename_column :volunteers_orientations,      :v_id,                :volunteer_id
    rename_column :volunteers_orientations,      :o_id,                :orientation_id
    
  end

  def self.down
    rename_column :orientations_projects,        :project_id,          :p_id
    rename_column :orientations_projects,        :orientation_id,      :o_id
    rename_table  :orientations_projects,        :orientation_projects

    rename_column :self_reports,                 :volunteer_id,        :v_id
    rename_column :self_reports,                 :project_id,          :p_id
    rename_column :self_reports,                 :supervisor_id,       :s_id

    rename_column :students,                     :volunteer_id,        :v_id

    rename_column :volunteer_extras,             :volunteer_id,        :v_id

    rename_column :volunteers_projects,          :volunteer_id,        :v_id
    rename_column :volunteers_projects,          :project_id,          :p_id
    rename_table  :volunteers_projects,          :volunteer_projects

    rename_column :volunteer_project_interests, :volunteer_id,        :v_id
    rename_column :volunteer_project_interests, :project_id,          :p_id

    rename_column :volunteers_orientations,      :volunteer_id,        :v_id
    rename_column :volunteers_orientations,      :orientation_id,      :o_id
    rename_table  :volunteers_orientations, 	   :orientation_registrations
 end
end
