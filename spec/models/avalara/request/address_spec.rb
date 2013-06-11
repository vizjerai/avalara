# encoding: UTF-8

require 'spec_helper'

describe Avalara::Request::Address do
  let(:params) { FactoryGirl.attributes_for(:address) }
  let(:address) { FactoryGirl.build_via_new(:address) }

  context 'sets all attributes' do
    subject { address }

    its(:Line1) { should == params[:line_1] }
    its(:Line2) { should == params[:line_2] }
    its(:Line3) { should == params[:line_3] }
    its(:City) { should == params[:city] }
    its(:Region) { should == params[:region] }
    its(:Country) { should == params[:country] }
    its(:PostalCode) { should == params[:postal_code] }
  end
end
