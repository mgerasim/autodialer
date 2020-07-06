class AnalysisSerializer < ActiveModel::Serializer
  attributes :id, :employee_active_count, :setting_trunk_active_count, :trunk_enable_count, :outgoing_count, :answer_count
end
