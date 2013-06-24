# encoding: UTF-8

require 'spec_helper'

describe Avalara::Request::Invoice do
  let(:params) { FactoryGirl.attributes_for(:invoice) }
  let(:invoice) { FactoryGirl.build_via_new(:invoice) }

  context 'sets all attributes' do
    subject { invoice }

    its(:CustomerCode) { should == params[:customer_code] }
    its(:DocDate) { should == Avalara::Types::Date.coerce(params[:doc_date]) }
    its(:CompanyCode) { should == params[:company_code] }
    its(:Commit) { should == params[:commit] }
    its(:CustomerUsageType) { should == params[:customer_usage_type] }
    its(:Discount) { should == params[:discount] }
    its(:DocCode) { should == params[:doc_code] }
    its(:PurchaseOrderNo) { should == params[:purchase_order_no] }
    its(:ExemptionNo) { should == params[:exemption_no] }
    its(:DetailLevel) { should == params[:detail_level] }
    its(:DocType) { should == params[:doc_type] }
    its(:Lines) { should == params[:lines] }
    its(:Addresses) { should == params[:addresses] }
    its(:ReferenceCode) { should == params[:reference_code] }
  end

  describe '#CompanyCode' do
    let(:invoice) { Avalara::Request::Invoice.new }

    it 'returns nil' do
      expect(invoice.CompanyCode).to eq Avalara.company_code
    end

    context 'with invoice company code' do
      let(:invoice) { Avalara::Request::Invoice.new :company_code => 'InvoiceInvoiceCode' }

      it 'returns invoice company code' do
        expect(invoice.CompanyCode).to eq 'InvoiceInvoiceCode'
      end
    end

    context 'with configuration company code' do
      let(:invoice) { Avalara::Request::Invoice.new }
      before { Avalara.configuration.company_code = 'TEST' }

      it 'returns configuration company code' do
        expect(invoice.CompanyCode).to eq 'TEST'
      end

      context 'with invoice company code' do
        let(:invoice) { Avalara::Request::Invoice.new :company_code => 'InvoiceInvoiceCode' }
        it 'allow overriding configuration company code' do
          expect(invoice.CompanyCode).to eq 'InvoiceInvoiceCode'
        end
      end
    end
  end

  context 'converts nested objects to json' do
    subject { invoice.to_json }
    it { should_not be_nil }
  end
end
