# frozen_string_literal: true

# Controller for handling blood pressure calculations.
require 'rails_helper'

# There needs to be a check for the following
# 1.High blood pressure
# 2.Pre-High blood pressure
# 3.Ideal blood pressure
# 4.Low blood pressure
# 5.Errors
# 6.High blood pressure edge case
# 7.Error text added to field
# 8.Pre-High edge cases test

RSpec.describe BloodPressureCalculatorController, type: :controller do
  describe 'POST #new' do
    it 'Check for high blood pressure' do
      post :new, params: { systolic: 180, diastolic: 90 } # Simulate post to #new and pass parameters
      expect(response).to be_successful # Check response object
      expect(assigns(:category)).to eq('High blood pressure') # Check @category vs the message
      puts "Test 1 - High Blood Pressure - Result = #{assigns(:category)}" # Print line to console to verify message
    end

    it 'Check for pre high blood pressure' do
      post :new, params: { systolic: 130, diastolic: 85 }
      expect(response).to be_successful
      expect(assigns(:category)).to eq('Pre-high blood pressure')
      puts "Test 2 - Pre-High Blood Pressure - Result = #{assigns(:category)}"
    end

    it 'Check for ideal blood pressure' do
      post :new, params: { systolic: 110, diastolic: 70 }
      expect(response).to be_successful
      expect(assigns(:category)).to eq('Ideal blood pressure')
      puts "Test 3 - Ideal Blood Pressure - Result = #{assigns(:category)}"
    end

    it 'Check for low blood pressure' do
      post :new, params: { systolic: 80, diastolic: 50 }
      expect(response).to be_successful
      expect(assigns(:category)).to eq('Low blood pressure')
      puts "Test 4 - Low Blood Pressure - Result = #{assigns(:category)}"
    end

    it 'Check there is a error message when values out of range of systolic and diastolic are entered' do
      post :new, params: { systolic: 200, diastolic: 110 }
      expect(response).to be_successful
      expect(assigns(:error_message)).to eq('Please review the measurements you have entered, The Valid Values are: Systolic (70-190), Diastolic (40-100).')
      puts "Test 5 - Error Message: Result = #{assigns(:error_message)}"
    end

    it 'Check edge case' do
      post :new, params: { systolic: 140, diastolic: 90 }
      expect(response).to be_successful
      expect(assigns(:category)).to eq('High blood pressure')
      puts "Test 6 - High Blood Pressure - Result = #{assigns(:category)}"
    end

    it 'Check there is a error message if text is added' do
      post :new, params: { systolic: 69, diastolic: 'VTN' }
      expect(response).to be_successful
      expect(assigns(:error_message)).to eq('Please review the measurements you have entered, The Valid Values are: Systolic (70-190), Diastolic (40-100).')
      puts "Test 7 - Error Message: Result from test is #{assigns(:error_message)}"
    end

    it 'Check Pre-High edge cases for OR condition' do
      post :new, params: { systolic: 130, diastolic: 75 }
      expect(response).to be_successful
      expect(assigns(:category)).to eq('Pre-high blood pressure')
      puts "Test 8 - Pre-High Blood Pressure - Result = #{assigns(:category)}"
    end
  end
end