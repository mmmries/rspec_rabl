shared_context "user_context" do
  let(:user){ double('user',
    guid: 'abc',
    first_name: 'gob',
    last_name: 'bluth',
    email: 'gob@bluth.com',
    password: 'very secret',
    is_deleted: false
  )}
end
