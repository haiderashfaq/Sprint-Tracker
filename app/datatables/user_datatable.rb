class UserDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      first_name: { source: "User.first_name", cond: :like, searchable: true, orderable: true },
      last_name:  { source: "User.last_name",  cond: :like, nulls_last: true },
      email:      { source: "User.email" },
      role_id:    { source: "User.role_id" },
    }
  end

  def data
    records.map do |record|
      {
      first_name: record.first_name,
      last_name:  record.last_name,
      email:      record.email,
      role_id:    record.role_id== 1? "Admin" : "Member",
      DT_RowId:   record.id,
        # example:
        # id: record.id,
        # name: record.name
      }
    end
  end

  def get_raw_records
    # insert query here
    @users = User.all
  end

end
