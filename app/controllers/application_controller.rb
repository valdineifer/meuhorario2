class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def contact
  end

  def send_contact
    return redirect_to(contact_us_path) if !verify_recaptcha

    data = {}
    data['name'] = params[:name]
    data['email'] = params[:email]
    data['message'] = params[:message]

    ContactMailer.contact(data).deliver_now

    redirect_to root_path
  end

  def export_schedule_pdf
    @classes = {}

    request.GET.each do |discipline_code, class_number|
      discipline = Discipline.find_by_code discipline_code
      dc = DisciplineClass.includes(:discipline).where(discipline: discipline, class_number: class_number).first

      unless dc.nil?
        schedules = []
        dc.schedules.each do |schedule|
          schedules << { day: schedule.day, daytime_number: schedule.daytime_number, class_count: schedule.class_count, discipline: dc.discipline.code }
        end
        @classes[dc] = schedules
      end
    end

    @colors = [ "antiquewhite", "aquamarine", "cadetblue", "cornflowerblue", "khaki",
                "greenyellow", "indianred", "lightblue", "lightgreen", "lightpink",
                "lightseagreen", "orchid", "yellowgreen", "goldgreen", "lightteal",
                "paleorange", "colorfulgray", "pinkishpurple"
              ].shuffle

    respond_to do |format|
      format.html
      format.pdf do
        render  pdf:          'grade_meuhorario',
                page_size:    'A4',
                zoom:         '1.27',
                orientation:  'Portrait',
                formats:      [ :html ],
                template:     'application/export_schedule_pdf'
      end
    end
  end

  def updating
  end
end
