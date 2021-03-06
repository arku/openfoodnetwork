# frozen_string_literal: false

require 'spec_helper'

describe Spree::UserSessionsController, type: :controller do
  let(:user) { create(:user) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:spree_user]
  end

  describe "create" do
    context "succeed" do
      context "when referer is not '/checkout'" do
        it "redirects to root" do
          spree_post :create, spree_user: { email: user.email, password: user.password }, use_route: :spree
          expect(response).to redirect_to root_path
        end
      end

      context "when referer is '/checkout'" do
        before { @request.env['HTTP_REFERER'] = 'http://test.com/checkout' }

        it "redirects to checkout" do
          spree_post :create, spree_user: { email: user.email, password: user.password }, use_route: :spree
          expect(response).to redirect_to checkout_path
        end
      end
    end
  end
end
