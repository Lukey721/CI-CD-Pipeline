require 'rails_helper'

#There needs to be a check for the following 
#1.High blood pressure
#2.Pre-High blood pressure
#3.Ideal blood pressure
#4.Low blood pressure
#5.Errors
#6.Edge cases

RSpec.describe BloodPressureCalculatorController, type: :controller do
  describe 'POST #new' do
    it 'Check for high blood pressure' do
      post :new, params: { systolic: 180, diastolic: 90}
      expect(response).to be_successful
      expect(assigns(:category)).to eq("High blood pressure")
    end 

    it 'Check for ideal blood pressure' do
      post :new, params: { systolic: 110, diastolic: 70 }
      expect(response).to be_successful
      expect(assigns(:category)).to eq("Ideal blood pressure")
    end

    it 'Check there is a error message when values out of range of systolic and diastolic are entered' do
      post :new, params: { systolic: 200, diastolic: 110 }
      expect(response).to be_successful
      expect(assigns(:error_message)).to eq("Please review the measurements you have entered, The Valid Values are: Systolic (70-190), Diastolic (40-100).")
    end
  end
end