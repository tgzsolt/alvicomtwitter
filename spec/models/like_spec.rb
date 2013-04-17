require 'spec_helper'

describe Like do

  let(:liker) { FactoryGirl.create(:user) }
  let(:micropost) { FactoryGirl.create(:micropost) }
  let(:like) { liker.like_relationships.build(micropost_id: micropost.id) }

  subject { like }

  it { should be_valid }

  describe "liker methods" do    
    it { should respond_to(:liker) }
    it { should respond_to(:micropost) }
    its(:liker) { should == liker }
    its(:micropost) { should == micropost }
  end
  
  describe "when micropost id is not present" do
    before { like.micropost_id = nil }
    it { should_not be_valid }
  end

  describe "when liker id is not present" do
    before { like.liker_id = nil }
    it { should_not be_valid }
  end
end