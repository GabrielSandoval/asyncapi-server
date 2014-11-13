require "spec_helper"

module Asyncapi
  module Server
    module V1
      describe JobsController, type: :controller do
        routes { Asyncapi::Server::Engine.routes }

        describe "GET index" do
          it "returns all jobs" do
            job_1 = create(:asyncapi_server_job)
            job_2 = create(:asyncapi_server_job)
            get :index, format: :json, page: 2, per_page: 1
            expect(response).to be_successful
            parsed_result = indifferent_hash(response.body)
            expect(parsed_result.first[:id]).to eq job_2.id
            expect(parsed_result.first[:url]).to eq job_2.url
          end
        end

        describe "GET show" do
          it "returns the job with the given id" do
            job = create(:asyncapi_server_job)
            get :show, format: :json, id: job.id
            expect(response).to be_successful
            parsed_result = indifferent_hash(response.body)[:job]
            expect(parsed_result[:id]).to eq job.id
            expect(parsed_result[:url]).to eq job.url
          end
        end

      end
    end
  end
end
