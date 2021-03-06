module AnsibleTowerClient
  class Job < BaseModel
    def self.endpoint
      "jobs".freeze
    end

    def extra_vars_hash
      extra_vars.empty? ? {} : hashify(:extra_vars)
    end

    def stdout
      out_url = related['stdout']
      return unless out_url
      api.get("#{out_url}?format=txt").body
    end
  end
end
