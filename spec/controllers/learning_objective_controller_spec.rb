require 'spec_helper'

describe LearningObjectiveController do
  describe "POST 'update'" do
    before do
      request.env["HTTP_REFERER"] = "http://distributedlife.com"
      @lo = LearningObjective.make(:pending => true)
    end

    context 'when learning objective id exists' do
      it 'should be a redirect' do
        post(:update, {:id => @lo.id})
        
        response.should be_redirect
      end

      it 'should not update the pending attribute if it is not supplied' do
        post(:update, {:id => @lo.id})
       
        @lo.reload
        @lo.pending.should == true;
      end

      it 'should update the pending attribute if it is supplied' do
        post(:update, {:id => @lo.id, :pending => false})

        @lo.reload
        @lo.pending.should == false;
      end

      it 'should redirect back with undo message' do
        post(:update, {:id => @lo.id, :pending => false})

        response.should redirect_to :back
        flash[:undo].should == "Changes saved. Click here to undo."
      end
    end

    context 'when resource supplied does not exist' do
      it 'should redirect with error message when redirect supplied' do
        post(:update, {:id => 0})

        response.should redirect_to :back
        flash[:error].should == "Unable to complete as the requested learning objective could not be found."
      end
    end
  end
end
