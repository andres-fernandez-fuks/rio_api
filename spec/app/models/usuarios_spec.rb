require 'spec_helper'

describe Usuario do
  context 'Creacion de usuario' do
    it 'cuando se crea con todos sus campos validos' do
        usuario = described_class.new('Fulanito', 'fulanito@gmail.com', '14')
        expect(usuario.nombre).to eq 'Fulanito'
        expect(usuario.mail).to eq 'fulanito@gmail.com'
        expect(usuario.id_telegram).to eq '14'
    end
  end
end
