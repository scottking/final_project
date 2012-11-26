require 'spec_helper'
include ActionView::Helpers::TextHelper # for pluralize

describe "BoardPages" do
  subject { page }

  describe 'listing' do
    before do
      30.times { FactoryGirl.create(:board) }
      visit boards_path
    end

    it 'should list all the boards' do
      Board.all.each {|b| should have_link(b.name, href: board_path(b)) }
    end
  end

  describe 'display' do
    let(:board) { FactoryGirl.create(:board) }

    before { visit board_path(board) }

    it { should have_content(board.name) }
    it { should have_content("Height: #{pluralize board.height, 'tile'}") }
    it { should have_content("Width: #{pluralize board.width, 'tile'}") }
    it { should have_content("Created by: #{board.user.name}") }
    it { should have_content(board.timezone) }
    it { should have_button('Create advertisement') }
  end
end
