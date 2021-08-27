class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.inherited(subclass)
    super
    def subclass.not_multitenant
      @multitenant = false
    end

    def subclass.multitenanted?
      @multitenant.nil?
    end

    trace = TracePoint.new(:end) do |tp|
      if tp.self == subclass && tp.self.multitenanted?
        trace.disable
        subclass.instance_eval { default_scope { where(company_id: Company.current_company) } }
      end
    end
    trace.enable
  end
end
