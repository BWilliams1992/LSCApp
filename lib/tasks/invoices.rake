desc "Checks to see if its new invoice day, if it is sends the last invoice and creates a new one"

task :make_invoices => [:environment] do
    Location.all.each do |location|
        puts "Site name: " + location.site_name
        puts "New invoice day " + location.start_date.day.to_s
        today = Date.today()
        if today.day == location.start_date.day
            puts "TODAY!"
            UserMailer.with(user: @invoice.location.user, invoice: location.invoices.last).invoice_email.deliver_now
            invoice = location.invoices.build(start_date:today, end_date:(today >> 1))
            if invoice.save
                puts "Invoice created"
            else
                puts "Error"
            end
        else
            puts "Not today"
        end
    end

end
