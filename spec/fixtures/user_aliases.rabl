object @user => :user
attributes  :guid => :id
node(:team){ 'Gorby Puff' }
node(:feed_is_deleted) { |user| user.is_deleted }
node(:i_am_nil) { |user| user.nil_value }
