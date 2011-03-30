require 'spec_helper'

describe VersionsController do
  context 'revert' do
    before do
      request.env["HTTP_REFERER"] = "http://distributedlife.com"
      
      @changed = LearningObjective.make
      @changed.pending = true
      @changed.save!

      @version = @changed.versions.last
    end

    context 'when succesful' do
      it 'should revert a version if it is the latest' do
        @changed.pending.should == true

        post(:revert, {:id => @version.id})

        @changed.reload
        @changed.pending.should == false
      end

      it 'should allow the most recent revert to be redone' do
        original_brief = @changed.brief
        @changed.brief = 'this is the second change'
        @changed.save!
        @changed.brief.should == 'this is the second change'

        @version = @changed.versions.last

        post(:revert, {:id => @version.id})

        @changed.reload
        @changed.brief.should == original_brief

        post(:revert, {:id => @version.next.id, :redo => 'true'})

        @changed.reload
        @changed.brief.should == 'this is the second change'
      end

      it 'should redirect to back with a redo link' do
        post(:revert, {:id => @version.id})

        response.should redirect_to :back
        flash[:success].should ~ /^Successfully reverted your change./
      end
    end

    context 'when unsuccessful' do
      it 'should not revert a version if the version id does not exist' do
        @changed.pending.should == true

        post(:revert, {:id => (@version.id + 1)})

        @changed.reload
        @changed.pending.should == true
      end

      it 'should not revert to a version that isnt immediately prior to the latest' do
        @changed.brief = 'bananana'
        @changed.save!

        @changed.pending.should == true
        @changed.brief.should == 'bananana'

        post(:revert, {:id => (@version.id)})

        @changed.reload
        @changed.pending.should == true
        @changed.brief.should == 'bananana'
      end

      it 'should redirect to back and report an error' do
        post(:revert, {:id => @version.id + 1})

        response.should redirect_to :back
        flash[:failure].should == "Could not make change. The record probably has changed since you made your change."
      end
    end
  end
end
