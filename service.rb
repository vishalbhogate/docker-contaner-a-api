require 'sinatra'
require "sinatra/namespace"

class Employee
    @@employee = [
        { id: "1", name: "John" },
        { id: "2", name: "Vicky" },
        { id: "3", name: "Sameer" }
    ]

    def self.all
        @@employee
    end

    def self.find(employee_id)
        @@employee.select { |p| p[:id] == employee_id }.first
    end
end

set :bind, '0.0.0.0'

# /healthcheck
get '/healthcheck' do
    'Healthy!!!'
end



namespace '/api/containerone' do

    before do
        content_type 'application/json'
    end

    # /api/containerone/employee
    get '/employee' do
        Employee.all.to_json
    end

    # /api/containerone/employee/:id
    get '/employee/:id' do
        if (employee = Employee.find(params[:id])) != nil
            employee.to_json
        else
            halt(404, { message:'employee Not Found'}.to_json)
        end
    end

end
