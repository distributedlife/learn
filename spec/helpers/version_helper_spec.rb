require 'spec_helper'

describe VersionHelper do
  context 'revert' do
    before do
      @changed = LearningObjective.make
      @changed.pending = true
      @changed.save!

      @version = @changed.versions.last
    end

   context 'when succesful' do
      it 'should revert a version if it is the latest' do
        @changed.pending.should == true

        VersionHelper.revert @version.id

        @changed.reload
        @changed.pending.should == false
      end

      it 'should allow the most recent revert to be redone' do
        original_brief = @changed.brief
        @changed.brief = 'this is the second change'
        @changed.save!
        @changed.brief.should == 'this is the second change'

        @version = @changed.versions.last

        VersionHelper.revert @version.id

        @changed.reload
        @changed.brief.should == original_brief

        VersionHelper.revert @version.next.id

        @changed.reload
        @changed.brief.should == 'this is the second change'
      end

      it 'should return the current version' do
        returned_version = VersionHelper.revert @version.id

        returned_version.should == @version
      end
    end

    context 'when unsuccessful' do
      it 'should not revert a version if the version id does not exist' do
        @changed.pending.should == true

        VersionHelper.revert(@version.id + 1)

        @changed.reload
        @changed.pending.should == true
      end

      it 'should not revert to a version that isnt immediately prior to the latest' do
        @changed.brief = 'bananana'
        @changed.save!

        @changed.pending.should == true
        @changed.brief.should == 'bananana'

        VersionHelper.revert @version.id

        @changed.reload
        @changed.pending.should == true
        @changed.brief.should == 'bananana'
      end

      it 'should return nil' do
        returned_version = VersionHelper.revert(@version.id + 1)

        returned_version.nil?.should == true
      end
    end
  end
end