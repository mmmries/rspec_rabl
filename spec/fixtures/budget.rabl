object @budget => 'budget'
attributes :name
node(:created_at){|budget| budget.created_at.to_i}
