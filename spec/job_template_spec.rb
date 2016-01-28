require_relative 'spec_helper'

describe AnsibleTowerClient::JobTemplate do
  let(:job_templates_body) do
    {:count => 2, :next => nil,
     :previous => nil,
     :results => [{:id => 1, :type => 'job_template',
                   :url => '/api/v1/job_templates/1', :name => 'test1'},
                  {:id => 2, :type => 'job_templates',
                   :url => '/api/v1/job_templates/2', :name => 'test2'}]}.to_json
  end

  let(:one_result) do
    {:id => 1, :url => '/api/v1/job_templates/1/', :name => 'test1'}.to_json
  end

  let(:api_connection) { instance_double("Faraday::Connection", :get => get) }

  describe '#JobTemplate.all' do
    let(:get) { instance_double("Faraday::Result", :body => job_templates_body) }

    it "returns a list of job_template objects" do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      all_job_templates = AnsibleTowerClient::JobTemplate.all
      expect(all_job_templates).to        be_a Array
      expect(all_job_templates.length).to eq(2)
      expect(all_job_templates.first).to  be_a AnsibleTowerClient::JobTemplate
    end
  end

  describe '#initialize' do
    it "instantiates an AnsibleTowerClient::JobTemplate from a hash" do
      parsed = JSON.parse(job_templates_body)['results'].first
      host = AnsibleTowerClient::JobTemplate.new(parsed)
      expect(host).to be_a AnsibleTowerClient::JobTemplate
      expect(host.id).to be_a Integer
      expect(host.name).to eq "test1"
    end
  end

  describe '#JobTemplate.find' do
    let(:get) { instance_double("Faraday::Result", :body => one_result) }

    it 'returns one record' do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      one_thing = AnsibleTowerClient::JobTemplate.find(1)
      expect(one_thing).to be_a AnsibleTowerClient::JobTemplate
    end
  end
end
