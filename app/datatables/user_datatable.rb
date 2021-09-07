class UserDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      name: { source: "User.name", cond: :like, searchable: true, orderable: true },
      email:      { source: "User.email" },
      role_id:    { source: "User.role_id" },
    }
  end

  def data
    records.map do |record|
      {
        name: record.name,
        email:      record.email,
        role_id:    record.role_id== 1? "Admin" : "Member",
        DT_RowId:   record.id,
      }
    end
  end

  def get_raw_records
    @users = User.all.rewhere(company_id: Company.current_company_id)
  end
end
