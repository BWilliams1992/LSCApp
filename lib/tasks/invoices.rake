desc "Create"

task :make_invoices => [:environment] do
    Location.all.each do |location|
        puts "Site name: " + location.site_name
        puts "New invoice day " + location.start_date.day.to_s
        today = Date.today()
        if today.day == location.start_date.day
            puts "TODAY!"
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

desc "Sends email copy of invoice"
task :send_invoice => [:environment] do
    @invoice = Invoice.first
    puts @invoice.invoice_cleans
    UserMailer.with(user: @invoice.location.user, invoice: @invoice).invoice_email.deliver_now
end