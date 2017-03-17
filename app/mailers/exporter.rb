class Exporter < ApplicationMailer
  default from: "\"Conferina\" <no-reply notifications@conferina.com>"

  def export_notes(note)
    @note = note
    @notable = @note.notable
    @user = @note.user

    mail(
      to: mail_to(@user),
      bcc: mail_bcc,
      subject: 'Your exported notes'
    )
  end

  def bulk_export_notes(notes)
    # @todo: Not efficent
    require 'csv'

    @notes = notes
    a_note = @notes.first
    @notable_type = a_note.notable_type.class
    @user = a_note.user

    attachments["#{@notable_type}_notes.csv"] = CSV.generate(headers: false) do |csv|
      @notes.each do |note|
        csv << [note.notable.name, note.content]
      end
    end

    mail(
      to: mail_to(@user),
      bcc: mail_bcc,
      subject: 'Your bulk exported notes'
    )
  end

end
