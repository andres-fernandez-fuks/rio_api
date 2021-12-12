require 'spec_helper'

describe EnviadorDeMails do
    context 'Cuando se le pide enviar un mail de cotizacion sin fallas a "test@gmail.com"' do
        destinatario = "test@gmail.com"
        mensaje = "El auto no presenta fallas"
        asunto = "Fiubak - Informe de cotizacion"
        it 'Se le envia un mail a "test@gmail.com" diciendo que todas las fallas son nulas' do
            expect(WebTemplate::App).to receive(:email).with({
                :body=>mensaje,
                :from=>"rio.job.vacancy@gmail.com",
                :subject=>asunto,
                :to=>destinatario})
            described_class.enviar_mail_a(destinatario, asunto, mensaje)
        end
    end
end
