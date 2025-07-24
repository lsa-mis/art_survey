require "csv"

class ReportsController < ApplicationController
  before_action :super_user_department_admin_access_authorized!

  def art_items
    @departments = current_user_department_objects
    @selected_department = params[:department_id].present? ? Department.find_by(id: params[:department_id]) : nil

    art_items = if is_super_user!
      if @selected_department
        ArtItem.where(department: @selected_department)
      else
        ArtItem.all
      end
    else
      if @selected_department && current_user_departments.include?(@selected_department.id)
        ArtItem.where(department: @selected_department)
      else
        ArtItem.where(department_id: current_user_departments)
      end
    end

    art_items = art_items.includes(:department, :appraisal_type, images_attachments: :blob)

    respond_to do |format|
      format.html # renders app/views/reports/art_items.html.erb
      format.csv do
        department_part = if @selected_department&.fullname.present?
          "-#{@selected_department.fullname.parameterize(separator: '_')}"
        else
          ''
        end
        send_data art_items_to_csv(art_items), filename: "art_items_report#{department_part}-#{Time.zone.today}.csv"
      end
    end
  end

  private

  def art_items_to_csv(art_items)
    headers = [
      'Department',
      'Department Contact',
      'Description',
      'Location Building',
      'Location Room',
      'Value Cost',
      'Date Acquired',
      'Appraisal Type',
      'Protection',
      'Appraisal Description',
      'Image URL'
    ]
    CSV.generate(headers: true) do |csv|
      csv << headers
      art_items.find_each do |item|
        csv << [
          item.department&.fullname,
          item.department_contact,
          item.description&.body&.to_plain_text,
          item.location_building,
          item.location_room,
          item.value_cost,
          item.date_acquired,
          item.appraisal_type&.classification,
          item.protection&.body&.to_plain_text,
          item.appraisal_description&.body&.to_plain_text,
          item.images.attached? ? url_for(item.images.first) : ''
        ]
      end
    end
  end
end
