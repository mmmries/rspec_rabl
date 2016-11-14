describe "Renderer Scope" do
  include_context "user_context"

  describe "user_renderer_scope.rabl" do
    rabl_data(:root => 'user'){ user }
    rabl_config(scope: RendererScopeHelper)

    it{ expect(subject).to render_attribute(:full_name).with_value('gob bluth') }
    it{ expect(subject).to render_attribute(:formatted_email).with_value('"gob bluth" <gob@bluth.com>') }
    it{ expect(subject).to render_attribute(:password).with_value('***********') }
  end

  describe "user_renderer_scope.rabl (without scope supplied)" do
    rabl_data(:root => 'user'){ user }
    rabl_template { "user_renderer_scope.rabl" }

    it "should fail if not configured with an appropriate scope" do
      expect{ rendered_template  }.to raise_error(NoMethodError)
    end
  end
end
